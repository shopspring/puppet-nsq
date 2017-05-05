# Class: nsq::nsqlookupd::config
# ===========================
#
# Configuration for nsqd
#
class nsq::nsqlookupd::config {

  file { "${::nsq::conf_dir}/nsqlookupd.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqlookupd.conf.erb'),
  }
}
