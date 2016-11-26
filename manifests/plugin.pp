# Installs the package for a given subscription_manager plugin
#
# === Parameters:
#
# $version::                       subscription-manager plugin package version, it's passed to ensure parameter of package resource
#                                  can be set to specific version number, 'latest', 'present' etc.
#
# $package::                       Name of the plugin
#
define subscription_manager::plugin(
  $version     = $subscription_manager::version,
  $package     = "subscription_manager-plugin-${title}",
) {
  package { $package:
    ensure => $version,
  }
}
