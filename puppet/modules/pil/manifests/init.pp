# installs PIL. PIL is rubbish to install because of broken
# dependencies on libjpeg etc, so we need to do some symlinking
class pil {

  package { [ 'libjpeg62-dev', 'zlib1g' ]:
    ensure => 'installed'
  }

  file { '/usr/lib/libjpeg.so':
    ensure  => 'link',
    target  => '/usr/lib/x86_64-linux-gnu/libjpeg.so'
  }

  file { '/usr/lib/libz.so':
    ensure  => 'link',
    target  => '/usr/lib/x86_64-linux-gnu/libz.so'
  }

}
