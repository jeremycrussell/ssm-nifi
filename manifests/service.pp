# @summary Manage the Apache NiFi service
#
# Private subclass for running Apache NiFi as a service
#
# @api private
class nifi::service (
  Stdlib::Absolutepath $nifi_home,
  String $user,
  Integer[0] $limit_nofile,
  Integer[0] $limit_nproc,
) {

  $service_params = {
    'nifi_home'    => $nifi_home,
    'user'         => $user,
    'limit_nofile' => $limit_nofile,
    'limit_nproc'  => $limit_nproc,
  }

  systemd::unit_file { 'nifi.service':
    content => epp('nifi/nifi.service.epp', $service_params),
    enable  => true,
    active  => true,
  }
}
