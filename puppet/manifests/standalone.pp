#
# Standalone manifest - for dev Vagrant box.
#

include vagrant::puppet::augeas

import "lib/*.pp"
import "common.pp"

line { 'line-venv-activate':
  ensure => present,
  line   => 'cd /vagrant',
  file   => '/home/vagrant/.bashrc',
}
