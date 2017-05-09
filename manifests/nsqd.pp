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
  Boolean $manage_service     = $::nsq::params::manage_service,
  Boolean $ensure_running     = $::nsq::params::ensure_running,
  Boolean $verbose_logging    = false,
  String $tcp_address         = '0.0.0.0:4160',
  String $http_address        = '0.0.0.0:4161',
  String $data_dir            = $::nsq::params::data_dir,
  String $statsd_address      = $::nsq::params::statsd_address,
  Array $nsqlookupd_addresses = [ '127.0.0.1:4160' ],
){
  include nsq::nsqd::config

  if $manage_service {
    # put systemd file in place
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
