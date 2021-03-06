
use strict;
use warnings;
use Module::Build;
my $build_class = 'Module::Build';
my $custom_build = 'Module::Build::Live';
eval("require $custom_build;");
unless($@) {
  warn "using custom build class:  '$custom_build'\n";
  $build_class = $custom_build;
}

my $builder = $build_class->new(
  module_name         => 'wxPerl::Constructors',
  license             => 'perl',
  dist_version_from   => 'lib/wxPerl/Constructors.pm',
  requires => {
    'Wx'            => 0.27,
    'Module::Build' => 0.26,
    'Test::More'    => 0,
  },
  add_to_cleanup      => [ qw(wxPerl-Constructors-* META.yml)],
);

$builder->create_build_script();

# vi:syntax=perl:ts=2:sw=2:et:sta
