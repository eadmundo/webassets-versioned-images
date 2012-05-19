import os, sys

from werkzeug.wrappers import Request, Response
from werkzeug.wsgi import SharedDataMiddleware

from webassets import Environment, Bundle, ExternalAssets

environment = Environment('static', '/static')

environment.versions = 'hash'
manifest_path = os.path.realpath(os.path.join(os.path.dirname(__file__), '.static-manifest'))
environment.manifest = 'file://%s' % manifest_path
environment.cache = False
environment.auto_build = True
environment.url = 'http://0.0.0.0:4000/static/'
#environment.debug = True

css = Bundle(
    'css/main.css',
    'css/sub/sub-main.css',
    filters='cssrewrite',
    output='gencss/css-merged.%(version)s.css'
)

externalassets = ExternalAssets(('css/img/*', 'img/*', 'css/sub/img/*'))

environment.register('css', css)
environment.register_externals(externalassets)
environment.config['external_assets_output_folder'] = 'genimg/' 

#print environment.manifest.get_manifest()

page = """
<!doctype html>
    <head>
        %(css_urls)s
    </head>
    <body>
        <div class="tiles">
            <div class="tile-0"></div>
            <div class="tile-1"></div>
            <div class="tile-2"></div>
            <div class="tile-3"></div>
            <div class="tile-4"></div>
            <div class="tile-5">
                <img width="133" height="133" src="%(tile_five)s">
            </div>
            <div class="tile-6"></div>
            <div class="tile-7"></div>
            <div class="tile-8"></div>
        </div>
    </body>
</html>
""" % (
    {
        'css_urls': ''.join(
            ['<link rel="stylesheet" type="text/css" href="%s" media="screen">\n' % url
                for url in environment['css'].urls()]
        ),
        'tile_five': environment.external_assets.url('css/img/tile-5.png')
    }
)

class Standalone(object):
    
    def __init__(self, static_folder, page):
        self.static_folder = static_folder
        self.page = page

    def dispatch_request(self, request):
        return Response(self.page, mimetype='text/html')

    def wsgi_app(self, environ, start_response):
        request = Request(environ)
        response = self.dispatch_request(request)
        return response(environ, start_response)

    def __call__(self, environ, start_response):
        return self.wsgi_app(environ, start_response)

def create_app(static_folder='/static', page='Hello World'):
    app = Standalone(static_folder, page)
    app.wsgi_app = SharedDataMiddleware(app.wsgi_app, {
        '/static':  os.path.join(os.path.dirname(__file__), 'static')
    })
    return app

if __name__ == "__main__":
    from werkzeug.serving import run_simple
    app = create_app('/static', page)
    run_simple('localhost', 4000, app, use_debugger=True, use_reloader=True)