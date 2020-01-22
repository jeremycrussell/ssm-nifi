# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

_Public Classes_

* [`nifi`](#nifi): Manage Apache NiFi

_Private Classes_

* `nifi::config`: Manage configuration for Apache NiFi
* `nifi::install`: Install Apache NiFi
* `nifi::service`: Manage the Apache NiFi service

## Classes

### nifi

Install, configure and run Apache NiFi

#### Examples

##### Defaults

```puppet
include nifi
```

##### Downloading from a different repository

```puppet
class { 'nifi':
  version                => 'x.y.z',
  download_url           => 'https://my.local.repo.example.com/apache/nifi/nifi-x.y.z.tar.gz',
  download_checksum      => 'abcde...',
}
```

#### Parameters

The following parameters are available in the `nifi` class.

##### `version`

Data type: `String`

The version of Apache NiFi. This must match the version in the
tarball. This is used for managing files, directories and paths in
the service.

Default value: '1.10.0'

##### `user`

Data type: `String`

The user owning the nifi installation files, and running the
service.

Default value: 'nifi'

##### `group`

Data type: `String`

The group owning the nifi installation files, and running the
service.

Default value: 'nifi'

##### `download_url`

Data type: `String`

Where to download the binary installation tarball from.

Default value: 'http://mirrors.ibiblio.org/apache/nifi/1.10.0/nifi-1.10.0-bin.tar.gz'

##### `download_checksum`

Data type: `String`

The expected checksum of the downloaded tarball. This is used for
verifying the integrity of the downloaded tarball.

Default value: 'fd4f0750d18137bb1c21cd0fd5ab8951ccd450e6f673b8988db93ea2ff408288'

##### `download_checksum_type`

Data type: `String`

The checksum type of the downloaded tarball. This is used for
verifying the integrity of the downloaded tarball.

Default value: 'sha256'

##### `service_limit_nofile`

Data type: `Integer`

The limit on number of open files permitted for the service. Used
for LimitNOFILE= in nifi.service.

Default value: 50000

##### `service_limit_nproc`

Data type: `Integer`

The limit on number of processes permitted for the service. Used
for LimitNPROC= in nifi.service.

Default value: 10000

##### `install_root`

Data type: `Stdlib::Absolutepath`

The root directory of the nifi installation.

Default value: '/opt/nifi'

##### `download_tmp_dir`

Data type: `Stdlib::Absolutepath`



Default value: '/var/tmp'
