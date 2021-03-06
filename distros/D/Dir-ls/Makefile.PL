# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "List the contents of a directory",
  "AUTHOR" => "Dan Book <dbook\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dir-ls",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.008001",
  "NAME" => "Dir::ls",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => "5.57",
    "Path::Tiny" => "0.097",
    "Sort::filevercmp" => 0,
    "locale" => 0,
    "sort" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::chdir" => 0,
    "Test::More" => "0.88"
  },
  "VERSION" => "0.004",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => "5.57",
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::chdir" => 0,
  "Path::Tiny" => "0.097",
  "Sort::filevercmp" => 0,
  "Test::More" => "0.88",
  "locale" => 0,
  "sort" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
