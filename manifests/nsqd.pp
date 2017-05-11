# Class: nsq::nsqd
# ===========================
#
# Responsible for configuration and management of nsqd
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
#   e.g. 0.0.0.0:4150
#
# * `http_address`
#   The IP and port nsqd will bind to for TCP connections
#   e.g. 0.0.0.0:4151
#
# * `data_dir`
#   Overflow will be stored on disk in this directory
#
# * `statsd_address`
#   location of statsd endpoint to write metrics to
#
# * `nsqlookupd_addresses`
#   Array of nsqlookupd addresses to connect to
#
class nsq::nsqd(
  Boolean $manage_service     = $::nsq::params::manage_service,
  Boolean $ensure_running     = $::nsq::params::ensure_running,
  Boolean $verbose_logging    = false,
  String $tcp_address         = '0.0.0.0:4150',
  String $http_address        = '0.0.0.0:4151',
  String $data_dir            = $::nsq::params::data_dir,
  String $statsd_address      = $::nsq::params::statsd_address,
  Array $nsqlookupd_addresses = [ '127.0.0.1:4160' ],
){
  include nsq::nsqd::config

  if $ensure_running {
    assert_type(Boolean, $manage_service)
    if ! $manage_service { fail ('$manage_service must be True if using $ensure_running') }
  }

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
