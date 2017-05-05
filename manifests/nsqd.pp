# Class: nsq::nslookupd
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
class nsq::nsqd(
  Boolean $manage_service  = $::nsq::params::manage_service,
  Boolean $ensure_running  = $::nsq::params::ensure_running,
  String $tcp_address      = '0.0.0.0:4160',
  String $http_address     = '0.0.0.0:4161',
  Boolean $verbose_logging = false,
){
  include nsq::nsqd::config

  if $manage_service {
    # put upstart file in place
    file { '/etc/systemd/system/nsqd.service':
      content => template('nsq/nsqd.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqd':
      enable => true,
      ensure => $ensure_running,
    }
  }
}
