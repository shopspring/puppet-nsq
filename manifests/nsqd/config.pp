# Class: nsq::nsqd::config
# ===========================
#
# Configuration for nsqd
#
class nsq::nsqd::config {

  file { "${::nsq::conf_dir}/nsqd.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqd.conf.erb'),
  }
}
