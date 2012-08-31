from flask import Flask, render_template
from flask.ext.assets import Environment, Bundle, ExternalAssets

app = Flask(__name__)
app.debug = True
app.config['ASSETS_DEBUG'] = False

assets = Environment(app)

css = Bundle(
    'css/main.css',
    'css/sub/sub-main.css',
    filters='cssrewrite',
    output='gencss/css-merged.%(version)s.css'
)

external_main = ExternalAssets(
    'css/img/*',
    'img/*',
    output='genimg/'
)

external_sub = ExternalAssets(
    'css/sub/img/*',
    output='genimg/'
)

assets.register('external_main', external_main)
assets.register('external_sub', external_sub)
assets.register('css', css)

#print app.config

@app.route('/')
def index():
    return render_template('index.jinja')

if __name__ == "__main__":
    app.run(host='0.0.0.0')