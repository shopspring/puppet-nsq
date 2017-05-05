# Class: nsq::nsqadmin::config
# ===========================
#
# Configuration for nsqadmin
#
class nsq::nsqadmin::config {

  file { "${::nsq::conf_dir}/nsqadmin.conf":
    ensure  => file,
    owner   => 'nsq',
    content => template('nsq/nsqadmin.conf.erb'),
  }
}
