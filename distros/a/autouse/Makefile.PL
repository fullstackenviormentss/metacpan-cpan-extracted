# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "postpone load of modules until a function is used",
  "AUTHOR" => "Ilya Zakharevich <ilya\@math.ohio-state.edu>, The Perl 5 Porters",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "autouse",
  "LICENSE" => "perl",
  "NAME" => "autouse",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "Scalar::Util" => "1.26"
  },
  "TEST_REQUIRES" => {
    "Errno" => 0
  },
  "VERSION" => "1.11",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Errno" => 0,
  "Exporter" => 0,
  "Scalar::Util" => "1.26"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
