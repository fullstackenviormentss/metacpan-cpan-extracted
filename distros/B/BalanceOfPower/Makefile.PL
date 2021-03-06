# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A game inspired by Balance of Power: The 1990 Edition by Chris Crawford ",
  "AUTHOR" => "Simone Fare' <cymon\@tiscali.it>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "BalanceOfPower",
  "EXE_FILES" => [
    "script/bop-perl"
  ],
  "LICENSE" => "perl",
  "NAME" => "BalanceOfPower",
  "PREREQ_PM" => {
    "Array::Utils" => 0,
    "Cwd" => 0,
    "Data::Dumper" => 0,
    "Exporter" => 0,
    "File::Path" => 0,
    "HTML::Entities" => 0,
    "IO::Prompter" => 0,
    "JSON" => 0,
    "LWP::UserAgent" => 0,
    "List::Util" => 0,
    "Module::Load" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "Template" => 0,
    "Template::Plugin::Filter::ANSIColor" => "0.0.3",
    "Term::ANSIColor" => 0,
    "constant" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "0.400115",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Array::Utils" => 0,
  "Cwd" => 0,
  "Data::Dumper" => 0,
  "Exporter" => 0,
  "File::Path" => 0,
  "HTML::Entities" => 0,
  "IO::Prompter" => 0,
  "JSON" => 0,
  "LWP::UserAgent" => 0,
  "List::Util" => 0,
  "Module::Load" => 0,
  "Moo" => 0,
  "Moo::Role" => 0,
  "Template" => 0,
  "Template::Plugin::Filter::ANSIColor" => "0.0.3",
  "Term::ANSIColor" => 0,
  "Test::More" => 0,
  "constant" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
