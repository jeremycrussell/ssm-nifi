# @summary Manage configuration for Apache NiFi
#
# Private subclass for Apache NiFi configuration
#
# @api private
class nifi::config (
  Stdlib::Absolutepath $nifi_home,
  Hash $bootstrap_conf,
  Hash $nifi_properties,
  String $user,
  String $group,
) {


  Concat {
    ensure_newline => true,
    owner => $user,
    group => $group,
    mode  => '0640',
  }

  $bootstrap_conf_file = "${nifi_home}/conf/bootstrap.conf"
  $nifi_properties_file = "${nifi_home}/conf/nifi.properties"

  concat { $bootstrap_conf_file:
  }

  $bootstrap_conf.each |String $key, Variant[Numeric,String] $value| {
    concat::fragment { "${bootstrap_conf_file} ${key}":
      target  => $bootstrap_conf_file,
      content => "${key} = ${value}\n"
    }
  }

  concat { $nifi_properties_file:
  }

  $nifi_properties.each |String $key, Variant[Numeric,String] $value| {
    concat::fragment { "${nifi_properties_file} ${key}":
      target  => $nifi_properties_file,
      content => "${key} = ${value}\n"
    }
  }

  # Make a persistent sensitive key.
  concat:fragment { "${$bootstrap_conf_file} nifi.bootstrap.sensitive.key":
    fqdn_rand()
  }


}
