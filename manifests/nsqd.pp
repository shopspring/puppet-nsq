# Class: nsq::nsqd
# ===========================
#
# Responsible for configuration and management of nsqd
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
  Boolean $service_manage                 = $::nsq::params::service_manage,
  Variant[Boolean, Undef] $service_ensure = $::nsq::params::service_ensure,
  Boolean $verbose_logging                = false,
  String $tcp_address                     = '0.0.0.0:4150',
  String $http_address                    = '0.0.0.0:4151',
  String $data_dir                        = $::nsq::params::data_dir,
  String $statsd_address                  = $::nsq::params::statsd_address,
  Array $nsqlookupd_addresses             = [ '127.0.0.1:4160' ],
){
  include nsq::nsqd::config

  if $service_ensure {
    assert_type(Boolean, $service_manage)
    if ! $service_manage { fail ('$service_manage must be True if using $service_ensure') }
  }

  if $service_manage {
    # put systemd file in place
    # TODO: should probably separate out systemd placement into its own option
    file { '/etc/systemd/system/nsqd.service':
      content => template('nsq/nsqd.service.erb'),
      notify  => Exec['systemd-reload'],
    }

    service { 'nsqd':
      ensure => $service_ensure,
      enable => true,
    }
  }
}
