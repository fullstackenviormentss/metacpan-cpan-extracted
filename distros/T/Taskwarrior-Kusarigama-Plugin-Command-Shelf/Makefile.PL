# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.011.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Move tasks to and from the shelf.",
  "AUTHOR" => "Shawn Sorichetti <shawn\@coloredblocks.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Taskwarrior-Kusarigama-Plugin-Command-Shelf",
  "LICENSE" => "perl",
  "NAME" => "Taskwarrior::Kusarigama::Plugin::Command::Shelf",
  "PREREQ_PM" => {
    "Clone" => 0,
    "JSON" => 0,
    "Moo" => 0,
    "MooseX::MungeHas" => 0,
    "Taskwarrior::Kusarigama::Hook::OnCommand" => 0,
    "Taskwarrior::Kusarigama::Plugin" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Clone" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "JSON" => 0,
  "Moo" => 0,
  "MooseX::MungeHas" => 0,
  "Taskwarrior::Kusarigama::Hook::OnCommand" => 0,
  "Taskwarrior::Kusarigama::Plugin" => 0,
  "Test::More" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
