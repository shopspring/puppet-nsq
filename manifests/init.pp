# Class: nsq
# ===========================
#
# Full description of class nsq here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
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
  class { '::nsq::install': } ->
  class { '::nsq::service': } ->
  Class['::nsq']
}
