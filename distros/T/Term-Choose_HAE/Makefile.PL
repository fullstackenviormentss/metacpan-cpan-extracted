use 5.010001;
use warnings;
use strict;
use ExtUtils::MakeMaker;

my %prereqs_os_specific;
if ( $^O eq 'MSWin32' ) {
    %prereqs_os_specific = (
        'Win32::Console::ANSI' => 0,
    );
}


WriteMakefile(
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.010001',
    LICENSE          => 'perl',
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
              type => 'git',
              web  => 'https://github.com/kuerbis/Term-Choose_HAE',
              url  => 'https://github.com/kuerbis/Term-Choose_HAE.git',
            },
        },
    },
    AUTHOR           => 'Matthaeus Kiem <cuer2s@gmail.com>',
    NAME             => 'Term::Choose_HAE',
    ABSTRACT_FROM    => 'lib/Term/Choose_HAE.pm',
    VERSION_FROM     => 'lib/Term/Choose_HAE.pm',
    EXE_FILES        => [],
    BUILD_REQUIRES   => {
        'lib'                   => 0,
        'File::Spec::Functions' => 0,
        'FindBin'               => 0,
        'Test::More'            => 0,
        'Test::Fatal'           => 0,
    },
    PREREQ_PM => {
        'if'                      => 0,
        'parent'                  => 0,
        'strict'                  => 0,
        'warnings'                => 0,
        'Exporter'                => 0,
        'Parse::ANSIColor::Tiny'  => 0,
        'Term::ANSIColor'         => 0,
        'Term::Choose'            => '1.511',
        'Term::Choose::LineFold'  => '1.511',
        'Term::Choose::Constants' => '1.511',
        'Text::ANSI::WideUtil'    => 0,
        %prereqs_os_specific
    },
    test  => {
        TESTS => 't/*/*.t',
    },
    dist  => {
        COMPRESS => 'gzip',
        SUFFIX   => '.gz',
        TARFLAGS => '--format=gnu -cvf',
    },
    clean => {
        FILES => 'Term-Choose_HAE-*',
    },
);
