# == Class nsq::install
#
# This class is called from nsq for install.
#
class nsq::install {
  include wget

  $package_name = "nsq-${::nsq::version}-compat.linux-amd64.go${::nsq::go_version}.tar.gz"

  user { 'nsq':
    ensure => present,
    system => true,
  }

  file { [ $::nsq::conf_dir, $::nsq::log_dir, $::nsq::data_dir ]:
    ensure  => directory,
    owner   => 'nsq',
    require => User[nsq],
  }

  wget::fetch { "https://s3.amazonaws.com/bitly-downloads/nsq/${package_name}":
    destination => '/tmp/',
    verbose     => false,
  }
  ->
  exec { 'untar':
    command => "tar -C ${::nsq::bin_dir} --strip-components=1 -xzf ${package_name}",
    cwd     => '/tmp',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    creates => "${::nsq::bin_dir}/bin/nsqd",
    unless  => "test -f ${::nsq::bin_dir}/bin/nsqd && ${::nsq::bin_dir}/bin/nsqd --version | grep ${::nsq::version}",
  }


}
