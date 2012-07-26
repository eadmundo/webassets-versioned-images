class ruby {

  package { ['ruby', 'rubygems']:
    ensure => installed,
    require => Package['ruby-augeas'],
  }

  package { ['sass', 'compass'] :
    ensure => installed,
    provider => gem,
    require => Package['ruby-augeas'],
  }

  package { ['less'] :
    ensure => '1.2.21',
    provider => gem,
    require => Package['ruby-augeas'],
  }

}
