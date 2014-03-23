# == Class: nodejs
#
# Install NodeJS for Darwin
#
# === Examples
#
#  class { nodejs: }
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class nodejs (
  $version = $nodejs::params::version
) inherits nodejs::params {

  class {'nodejs::install': }

}
