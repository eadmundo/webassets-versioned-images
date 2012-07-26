# Original recipe by niallo: https://gist.github.com/2003430
# Full Puppet module: https://github.com/garthk/puppet-chrislea

class python_software_properties {
  $package = "python-software-properties"
  package { $package:
    ensure => installed,
  }
}

define chrislea() {
  include python_software_properties
  exec { "chrislea-repo-added-${name}" :
    command => "/usr/bin/add-apt-repository ppa:chris-lea/${name}",
    creates => "/etc/apt/sources.list.d/chris-lea-${name}-${lsbdistcodename}.list",
    require => Package[$::python_software_properties::package],
  }

  exec { "chrislea-repo-ready-${name}" :
    command => "/usr/bin/apt-get update",
    require => Exec["chrislea-repo-added-${name}"],
    creates => "/var/lib/apt/lists/ppa.launchpad.net_chris-lea_${name}_ubuntu_dists_${lsbdistcodename}_Release",
    timeout => 3600,
  }
}

class nodejs {
  chrislea { 'node.js': }
  package { ["nodejs", "nodejs-dev", "npm"]:
    ensure => installed,
    require => Chrislea['node.js'],
  }

  # other packages we need, e.g. g++ to compile node-expat
  package { ["g++", "libexpat1-dev"]:
    ensure => installed,
  }

  exec { 'less-install':
    command => '/usr/bin/npm install -g less',
    creates => '/usr/bin/lessc',
    require => Package['npm'],
  }

  exec { 'uglify-js-install':
    command => '/usr/bin/npm install -g uglify-js',
    creates => '/usr/bin/lessc',
    require => Package['npm'],
  }

  exec { 'coffee-script-install':
    command => '/usr/bin/npm install -g coffee-script',
    creates => '/usr/bin/lessc',
    require => Package['npm'],
  }
  /*
  exec { 'clean-css-install':
    command => '/usr/bin/npm install -g clean-css',
    creates => '/usr/bin/lessc',
    require => Package['npm'],
  }
  */
}