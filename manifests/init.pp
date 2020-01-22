# @summary Manage Apache NiFi
#
# Install, configure and run Apache NiFi
#
# @param version
#   The version of Apache NiFi. This must match the version in the
#   tarball. This is used for managing files, directories and paths in
#   the service.
#
# @param user
#   The user owning the nifi installation files, and running the
#   service.
#
# @param group
#   The group owning the nifi installation files, and running the
#   service.
#
# @param download_url
#   Where to download the binary installation tarball from.
#
# @param download_checksum
#   The expected checksum of the downloaded tarball. This is used for
#   verifying the integrity of the downloaded tarball.
#
# @param download_checksum_type
#   The checksum type of the downloaded tarball. This is used for
#   verifying the integrity of the downloaded tarball.
#
# @param service_limit_nofile
#   The limit on number of open files permitted for the service. Used
#   for LimitNOFILE= in nifi.service.
#
# @param service_limit_nproc
#   The limit on number of processes permitted for the service. Used
#   for LimitNPROC= in nifi.service.
#
# @param install_root
#   The root directory of the nifi installation.
#
# @param nifi_properties
#   Properties for conf/nifi.properties
#
# @param bootstrap_conf
#   Properties for config/bootstrap.conf
#
# @example Defaults
#   include nifi
#
# @example Downloading from a different repository
#   class { 'nifi':
#     version                => 'x.y.z',
#     download_url           => 'https://my.local.repo.example.com/apache/nifi/nifi-x.y.z.tar.gz',
#     download_checksum      => 'abcde...',
#   }
#
class nifi (
  Hash $bootstrap_conf,
  Hash $nifi_properties,
  String $version = '1.10.0',
  String $download_url = 'http://mirrors.ibiblio.org/apache/nifi/1.10.0/nifi-1.10.0-bin.tar.gz',
  String $download_checksum = 'fd4f0750d18137bb1c21cd0fd5ab8951ccd450e6f673b8988db93ea2ff408288',
  Stdlib::Absolutepath $download_tmp_dir = '/var/tmp',
  String $user = 'nifi',
  String $group = 'nifi',
  String $download_checksum_type = 'sha256',
  Integer $service_limit_nofile = 50000,
  Integer $service_limit_nproc = 10000,
  Stdlib::Absolutepath $install_root = '/opt/nifi',
) {

  $nifi_home = "${install_root}/nifi-${version}"

  class { 'nifi::install':
    install_root           => $install_root,
    version                => $version,
    user                   => $user,
    group                  => $group,
    download_url           => $download_url,
    download_checksum      => $download_checksum,
    download_checksum_type => $download_checksum_type,
    download_tmp_dir       => $download_tmp_dir,
  }

  class { 'nifi::config':
    nifi_home       => $nifi_home,
    user            => $user,
    group           => $group,
    bootstrap_conf  => $bootstrap_conf,
    nifi_properties => $nifi_properties,
  }

  class {'nifi::service':
    nifi_home    => $nifi_home,
    user         => $user,
    limit_nofile => $service_limit_nofile,
    limit_nproc  => $service_limit_nproc,
  }

  Class['nifi::install'] -> Class['nifi::config'] ~> Class['nifi::service']
}
