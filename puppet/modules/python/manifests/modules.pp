class python::modules {
  package { [ 'python-virtualenv', 'python-mysqldb', 'python-dev', ]:
    ensure => 'installed'
  }
}
