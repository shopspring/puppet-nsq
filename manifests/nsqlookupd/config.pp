# Class: nsq::nsqlookupd::config
# ===========================
#
# Configuration for nsqlookupd
#
class nsq::nsqlookupd::config {

  $notify_service = $nsq::nsqlookupd::manage_service ? {
    true    => Service['nsqlookupd'],
    false   => undef,
    default => undef,
  }

  file { "${::nsq::conf_dir}/nsqlookupd.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqlookupd.conf.erb'),
    notify  => $notify_service,
  }
}
