class puppet {
  file { '/usr/local/sbin/puppet-run':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '755',
    source => 'puppet:///modules/puppet/puppet-run'
  }
}
