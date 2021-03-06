
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.031.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Template::Alloy (TT) View Class",
  "AUTHOR" => "Dean Hamstead <dean\@bytefoundry.com.au>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Catalyst-View-TT-Alloy",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Catalyst::View::TT::Alloy",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Catalyst" => "5.7",
    "Data::Dump" => 0,
    "Path::Class" => 0,
    "Scalar::Util" => 0,
    "Template::Alloy" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Catalyst::Test" => 0
  },
  "VERSION" => "0.00007",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Catalyst" => "5.7",
  "Catalyst::Test" => 0,
  "Data::Dump" => 0,
  "ExtUtils::MakeMaker" => 0,
  "Path::Class" => 0,
  "Scalar::Util" => 0,
  "Template::Alloy" => 0,
  "parent" => 0,
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



