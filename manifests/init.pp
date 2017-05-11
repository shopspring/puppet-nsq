# Class: nsq
# ===========================
#
# Full description of class nsq here.
#
# Parameters
# ----------
#
# * `version`
#   Version to install
#
# * `go_version`
#   Specify Go version of package you want to install.
#   Sometimes the same version could be compiled with different Go versions
#
# * `conf_dir`
#   Where configuration files will live
#
# * `data_dir`
#   Overflow will be stored on disk in this directory
#
# * `log_dir`
#   NSQ by default just outputs to stdout/stderr.  If using $manage_service
#   logs will be redirected to this directory in the systemd service script
#
# * `bin_dir`
#   Where binaries will be installed to
#
class nsq (
  String $version = $::nsq::params::version,
  String $go_version = $::nsq::params::go_version,
  String $conf_dir = $::nsq::params::conf_dir,
  String $data_dir = $::nsq::params::data_dir,
  String $log_dir = $::nsq::params::log_dir,
  String $bin_dir = $::nsq::params::bin_dir,
) inherits ::nsq::params {

  # validate parameters here
  class { '::nsq::install': }
  -> class { '::nsq::service': }
  -> Class['::nsq']
}
