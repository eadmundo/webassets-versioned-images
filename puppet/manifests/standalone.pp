#
# Standalone manifest - for dev Vagrant box.
#

include vagrant::puppet::augeas

import "lib/*.pp"
import "common.pp"
