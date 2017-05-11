# Class: nsq::nsqlookupd
# ===========================
#
# Responsible for configuration and management of nsqlookupd
#
# Parameters
# ----------
#
# * `manage_service`
#   Installs a systemd unit file and registers it as a service
#
# * `ensure_running`
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
  Boolean $manage_service  = $::nsq::params::manage_service,
  Boolean $ensure_running  = $::nsq::params::ensure_running,
  Boolean $verbose_logging = false,
  String $tcp_address      = '0.0.0.0:4160',
  String $http_address     = '0.0.0.0:4161',
){
# configure and setup service
  include nsq::nsqlookupd::config

  if $ensure_running {
    assert_type(Boolean, $manage_service)
    if ! $manage_service { fail ('$manage_service must be True if using $ensure_running') }
  }

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

