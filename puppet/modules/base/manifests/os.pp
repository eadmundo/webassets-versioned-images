class base::os::packages {
  package { [ 'git' ]:
    ensure => 'installed'
  }
  package { 'Fabric':
    provider => 'pip',
    ensure   => 'present'
  }
}
