# Class: nsq::nsqlookupd
# ===========================
#
# Responsible for configuration and management of nsqlookupd
#
# Parameters
# ----------
#
# * `service_manage`
#   Installs a systemd unit file and registers it as a service
#
# * `service_ensure`
#   Ensure nsqd service is running
#
# * `verbose_logging`
#   Toggle verbose logging
#
# * `tcp_address`
#   The IP and port nsqd will bind to for TCP connections
#   e.g. 0.0.0.0:4160
#
# * `http_address`
#   The IP and port nsqd will bind to for TCP connections
#   e.g. 0.0.0.0:4161
#
#
class nsq::nsqlookupd(
  Boolean $service_manage                 = $::nsq::params::service_manage,
  Variant[Boolean, Undef] $service_ensure = $::nsq::params::service_ensure,
  Boolean $verbose_logging                = false,
  String $tcp_address                     = '0.0.0.0:4160',
  String $http_address                    = '0.0.0.0:4161',
){
# configure and setup service
  include nsq::nsqlookupd::config

  if $service_ensure {
    assert_type(Boolean, $service_manage)
    if ! $service_manage { fail ('$service_manage must be True if using $service_ensure') }
  }

  if $service_manage {
    # put upstart file in place
    file { '/etc/systemd/system/nsqlookupd.service':
      content => template('nsq/nsqlookupd.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqlookupd':
      ensure => $service_ensure,
      enable => true,
    }
  }
}

