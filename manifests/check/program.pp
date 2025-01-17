# monit::check::program
#
# Implement Monit's CHECK PROGRAM
#
# @param ensure Enum['present', 'absent'] Whether this check must be present or absent.
# @param group String Monit group.
# @param alerts Array[String] Alert recipients (with event filters) to set.
# @param noalerts Array[String] Alerts to disable for this check.
# @param tests Array[Hash[String, Variant[Array, Hash, Integer, String]]] Monit tests.
# @param depends Array[String] Dependencies of this check on other checks.
# @param priority String Used as a prefix for the filename generated. Load order doesn't matter to Monit. This is just a facility to organize your checks by filename.
# @param bundle String Used to group checks by filename. All checks in the same bundle will be added to the same filename.
# @param order Integer Order of the check within the bundle filename.
# @param template String Template used to generate the check file.
# @param path Stdlib::Absolutepath Path to the program to run. May include arguments.
#
define monit::check::program(
  # Common parameters.
  Enum[
    'present',
    'absent'
    ] $ensure                 = present,
  String $group               = $name,
  String $additional_content  = "",
  Array[String] $alerts       = [],
  Array[String] $noalerts     = [],
  Array[
    Hash[String, Variant[Array, Hash, Integer, String]]
    ] $tests                  = [],
  Array[String] $depends      = [],
  String $priority            = '20',
  String $bundle              = $name,
  Integer $order              = 0,

  # Check type specific.
  String $template           = 'monit/check/program.erb',
  Stdlib::Absolutepath $path
) {

  monit::check::instance { "${name}_instance":
    ensure              => $ensure,
    name                => $name,
    type                => 'program',
    header              => template($template),
    group               => $group,
    alerts              => $alerts,
    noalerts            => $noalerts,
    tests               => $tests,
    depends             => $depends,
    priority            => $priority,
    bundle              => $bundle,
    order               => $order,
    additional_content  => $additional_content,
  }
}

