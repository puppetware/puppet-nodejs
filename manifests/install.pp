# == Class: nodejs::install
#
# Install NodeJS for Darwin
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class nodejs::install {

  $version = $nodejs::version

  $arch = $::architecture ? {
    /(x86_64|amd64)/ => 'x64',
    'i386'           => 'x86',
    default          => fail("Unrecognized architecture: ${::architecture}")
  }

  case $::kernel {
    'Darwin': {
       $source = "http://nodejs.org/dist/v${version}/node-v${version}-darwin-${arch}.tar.gz"
    }
    default: {
      fail("Unsupported Kernel: ${::kernel}, Operating System: ${::operatingsystem}")
    }
  }

  Exec {
    cwd => '/tmp',
    path => '/usr/sbin:/usr/bin:/bin',
    onlyif => "test ! -f /var/db/.puppet_pkg_installed_nodejs-${version}",
  }

  exec {'nodejs-download':
    command => "curl -o node-v${version}-darwin-${arch}.tar.gz -C - -k -L -s --url ${source}",
  }
  ->
  exec {'nodejs-extract':
    command => "tar -xzvf node-v${version}-darwin-${arch}.tar.gz",
  }
  ->
  exec {'nodejs-install-bin':
    command => 'cp -rf ./bin /usr/local',
    cwd => "/tmp/node-v${version}-darwin-${arch}",
    user => 'root',
  }
  ->
  exec {'nodejs-install-lib':
    command => 'cp -rf ./lib /usr/local',
    cwd => "/tmp/node-v${version}-darwin-${arch}",
    user => 'root',
  }
  ->
  exec {'nodejs-install-share':
    command => 'cp -rf ./share /usr/local',
    cwd => "/tmp/node-v${version}-darwin-${arch}",
    user => 'root',
  }
  ->
  file {"/tmp/node-v${version}-darwin-${arch}":
    ensure => absent,
    recurse => true,
    force => true,
    subscribe => [Exec['nodejs-install-bin'], Exec['nodejs-install-lib'], Exec['nodejs-install-share'] ]
  }
  ->
  file {"/tmp/node-v${version}-darwin-${arch}.tar.gz":
    ensure => absent,
  }
  ->
  file {"/var/db/.puppet_pkg_installed_nodejs-${version}":
    ensure => file,
    content => "name:'nodejs'\nsource:'${source}'",
    owner => 'root',
    group => 'wheel',
    mode => '0644',
  }
}