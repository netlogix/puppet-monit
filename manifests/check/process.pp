define monit::check::process(
  # Common parameters.
  $ensure     = present,
  $group      = $name,
  $alerts     = [],
  $noalerts   = [],
  $tests      = [],
  $depends    = [],
  $priority   = '20',
  $bundle     = $name,
  $order      = 0,

  # Check type specific.
  $template        = "monit/check/process.erb",
  $pidfile,
  $uid             = undef,
  $gid             = undef,
  $program_start,
  $program_stop,
  $timeout         = undef,
  $timeout_start   = undef,
  $timeout_stop    = undef,
) {
  validate_absolute_path($pidfile)

  if $timeout {
    $real_timeout_start   = pick($timeout_start, $timeout)
    $real_timeout_stop    = pick($timeout_stop, $timeout)
  }

  monit::check::instance { "${name}_instance":
    name     => $name,
    ensure   => $ensure,
    type     => 'process',
    priority => $priority,
    bundle   => $bundle,
    order    => $order,
    template => $template,
    tests    => $tests,
  }
}
