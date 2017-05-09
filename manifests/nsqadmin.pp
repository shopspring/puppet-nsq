# Class: nsq::nsqadmin
# ===========================
#
# Full description of class nsq here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class nsq::nsqadmin(
  Boolean $manage_service     = $::nsq::params::manage_service,
  Boolean $ensure_running     = $::nsq::params::ensure_running,
  String $http_address        = '0.0.0.0:4171',
  Array $nsqlookupd_addresses = [ '127.0.0.1:4161' ],
){
  include nsq::nsqadmin::config

  if $manage_service {
    # put upstart file in place
    file { '/etc/systemd/system/nsqadmin.service':
      content => template('nsq/nsqadmin.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqadmin':
      ensure => $ensure_running,
      enable => true,
    }
  }

}
