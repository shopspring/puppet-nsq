# Class: nsq::nsqadmin
# ===========================
#
# Responsible for configuration and management of nsqadmin
#
# Parameters
# ----------
#
# * `service_manage`
#   Installs a systemd unit file and registers it as a service
#
# * `service_ensure`
#   Ensure nsqadmin service is running
#
# * `http_address`
#   The IP and port nsqadmin will bind to.  e.g. 0.0.0.0:4171
#
# * `statsd_prefix`
#   Prefix for the keys sent to statsd (%s for host replacement)
#
# * `nsqlookupd_addresses`
#   Array of nsqlookupd addresses to connect to
#
# * `log_level`
#   Set logging level: debug, info, warn, error or fatal
#
class nsq::nsqadmin(
  Boolean $service_manage     = $::nsq::params::service_manage,
  Variant[Boolean, Enum[true, false, 'running', 'stopped'], Undef]
  $service_ensure             = $::nsq::params::service_ensure,
  String $http_address        = '0.0.0.0:4171',
  Array $nsqlookupd_addresses = [ '127.0.0.1:4161' ],
  String $statsd_prefix       = $::nsq::params::statsd_prefix,
  String $log_level           = $::nsq::params::log_level,
){
  include nsq::nsqadmin::config

  if $service_ensure {
    assert_type(Boolean, $service_manage)
    if ! $service_manage { fail ('$service_manage must be True if using $service_ensure') }
  }

  if $service_manage {
    # put upstart file in place
    file { '/etc/systemd/system/nsqadmin.service':
      content => template('nsq/nsqadmin.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqadmin':
      ensure => $service_ensure,
      enable => true,
    }
  }

}
