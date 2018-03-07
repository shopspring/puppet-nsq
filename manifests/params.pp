# == Class nsq::params
#
# This class is meant to be called from nsq.
# It sets variables according to platform.
#
class nsq::params {
  $go_version = '1.8'

  $version = '1.0.0'

  $conf_dir = '/etc/nsq'

  $log_dir = '/var/log/nsq'

  $bin_dir = '/usr/local'

  $data_dir = '/var/lib/nsq'

  $service_manage = true

  $service_ensure = undef

  $statsd_address = '127.0.0.1:8125'

  $statsd_prefix = 'nsq.%s'

  $msg_timeout = '60s'

  $max_msg_timeout = '15m'

  $max_req_timeout = '1h'
  $http_client_connect_timeout = '2s'
  $http_client_request_timeout = '5s'

  $log_level = 'info'
}
