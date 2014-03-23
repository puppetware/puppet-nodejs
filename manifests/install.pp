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
  $source = "http://nodejs.org/dist/v${version}/node-v${version}.pkg"

  package {"nodejs-${version}":
    ensure => 'installed',
    source => "${$source}",
    provider => 'pkgdmg',
  }

}
