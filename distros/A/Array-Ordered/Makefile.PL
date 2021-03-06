use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Array::Ordered',
    AUTHOR           => q{S. Randall Sawyer <srandallsawyer@cpan.org>},
    VERSION_FROM     => 'lib/Array/Ordered.pm',
    ABSTRACT_FROM    => 'lib/Array/Ordered.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION    => 5.006,
    CONFIGURE_REQUIRES  => {
        'ExtUtils::MakeMaker'
	                => 0,
    },
    BUILD_REQUIRES      => {
        'Test::Simple'	=> 0,
    },
    PREREQ_PM => {
        'Scalar::Util'  => 0,
        'Exporter'      => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Array-Ordered-*' },
);
