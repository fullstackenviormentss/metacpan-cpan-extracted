
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v6.011.
use strict;
use warnings;

use Module::Build 0.28;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.28"
  },
  "configure_requires" => {
    "Module::Build" => "0.28"
  },
  "dist_abstract" => "Be like SHLOMIF / Shlomi Fish.",
  "dist_author" => [
    "Shlomi Fish <shlomif\@cpan.org>"
  ],
  "dist_name" => "Task-BeLike-SHLOMIF",
  "dist_version" => "0.0.2",
  "license" => "mit",
  "module_name" => "Task::BeLike::SHLOMIF",
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::PluginBundle::SHLOMIF" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Pod::Xhtml" => 0,
    "SQ" => 0,
    "Task::FreecellSolver::Testing" => 0,
    "Task::Sites::ShlomiFish" => 0,
    "Term::ReadLine::Gnu" => 0,
    "Term::ReadLine::Perl5" => 0,
    "Test::Pod" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "test_requires" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.88",
    "perl" => "5.006"
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.28",
  "Test::More" => "0.88",
  "perl" => "5.006"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;
