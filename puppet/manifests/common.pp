include base
include python::modules
include pil
include nodejs
include ruby

# Packages required for application's venv to build
package { [ 'libmysqlclient-dev', 'libreadline-dev' ]:
  ensure => 'installed'
}
