# Class: nsq::nsqlookupd
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
class nsq::nsqlookupd(
  Boolean $manage_service  = $::nsq::params::manage_service,
  Boolean $ensure_running  = $::nsq::params::ensure_running,
  String $tcp_address      = '0.0.0.0:4160',
  String $http_address     = '0.0.0.0:4161',
  Boolean $verbose_logging = false,
){
# configure and setup service
  include nsq::nsqlookupd::config

  if $manage_service {
    # put upstart file in place
    file { '/etc/systemd/system/nsqlookupd.service':
      content => template('nsq/nsqlookupd.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqlookupd':
      ensure => $ensure_running,
      enable => true,
    }
  }
}

