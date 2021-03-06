# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Pass CSV files to AWK.",
  "AUTHOR" => "Bryan McKelvey <bryan.mckelvey\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "CSVAWK",
  "EXE_FILES" => [
    "bin/csvawk"
  ],
  "LICENSE" => "perl",
  "NAME" => "CSVAWK",
  "PREREQ_PM" => {
    "English" => 0,
    "Exporter" => 0,
    "File::Basename" => 0,
    "File::Temp" => 0,
    "Readonly" => 0,
    "Text::CSV_XS" => 0,
    "autodie" => 0,
    "base" => 0,
    "charnames" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "Module::Metadata" => 0,
    "Test" => 0,
    "Test::CleanNamespaces" => "0.13",
    "Test::Fatal" => "0.001",
    "Test::More" => "0.96"
  },
  "VERSION" => "0.1",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "English" => 0,
  "Exporter" => 0,
  "File::Basename" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "Module::Metadata" => 0,
  "Readonly" => 0,
  "Test" => 0,
  "Test::CleanNamespaces" => "0.13",
  "Test::Fatal" => "0.001",
  "Test::More" => "0.96",
  "Text::CSV_XS" => 0,
  "autodie" => 0,
  "base" => 0,
  "charnames" => 0,
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
