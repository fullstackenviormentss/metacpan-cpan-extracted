# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Code shared by the MaxMind DB reader and writer modules",
  "AUTHOR" => "Dave Rolsky <drolsky\@maxmind.com>, Olaf Alders <oalders\@maxmind.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "MaxMind-DB-Common",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.008",
  "NAME" => "MaxMind::DB::Common",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper::Concise" => 0,
    "DateTime" => 0,
    "Exporter" => 0,
    "List::AllUtils" => 0,
    "Math::BigInt" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "MooX::StrictConstructor" => 0,
    "Scalar::Util" => 0,
    "Sub::Quote" => 0,
    "autodie" => 0,
    "constant" => 0,
    "namespace::autoclean" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.040001",
  "test" => {
    "TESTS" => "t/*.t t/MaxMind/DB/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper::Concise" => 0,
  "DateTime" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "List::AllUtils" => 0,
  "Math::BigInt" => 0,
  "Moo" => 0,
  "Moo::Role" => 0,
  "MooX::StrictConstructor" => 0,
  "Scalar::Util" => 0,
  "Sub::Quote" => 0,
  "Test::More" => "0.96",
  "autodie" => 0,
  "constant" => 0,
  "namespace::autoclean" => 0,
  "overload" => 0,
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
