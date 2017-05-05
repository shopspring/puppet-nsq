# == Class nsq::service
#
#
class nsq::service {
  exec { 'systemd-reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }
}
