# Class: nsq::nsqadmin
# ===========================
#
# Responsible for configuration and management of nsqadmin
#
# Parameters
# ----------
#
# * `manage_service`
#   Installs a systemd unit file and registers it as a service
#
# * `ensure_running`
#   Ensure nsqadmin service is running
#
# * `http_address`
#   The IP and port nsqadmin will bind to.  e.g. 0.0.0.0:4171
#
# * `nsqlookupd_addresses`
#   Array of nsqlookupd addresses to connect to
#
class nsq::nsqadmin(
  Boolean $manage_service     = $::nsq::params::manage_service,
  Boolean $ensure_running     = $::nsq::params::ensure_running,
  String $http_address        = '0.0.0.0:4171',
  Array $nsqlookupd_addresses = [ '127.0.0.1:4161' ],
){
  include nsq::nsqadmin::config

  if $ensure_running {
    assert_type(Boolean, $manage_service)
    if ! $manage_service { fail ('$manage_service must be True if using $ensure_running') }
  }

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
