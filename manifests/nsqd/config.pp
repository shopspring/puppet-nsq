# Class: nsq::nsqd::config
# ===========================
#
# Configuration for nsqd
#
class nsq::nsqd::config {

  $notify_service = $nsq::nsqd::manage_service ? {
    true    => Service['nsqd'],
    false   => undef,
    default => undef,
  }

  file { "${::nsq::conf_dir}/nsqd.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqd.conf.erb'),
    notify  => $notify_service,
  }

}
