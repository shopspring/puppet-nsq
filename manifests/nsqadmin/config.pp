# Class: nsq::nsqadmin::config
# ===========================
#
# Configuration for nsqadmin
#
class nsq::nsqadmin::config {

  $notify_service = $nsq::nsqadmin::service_manage ? {
    true    => Service['nsqadmin'],
    false   => undef,
    default => undef,
  }

  file { "${::nsq::conf_dir}/nsqadmin.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqadmin.conf.erb'),
    notify  => $notify_service,
  }
}
