use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Astro::STSDAS::Table',
    'VERSION' => '0.13',
    'PREREQ_PM' => { Test::More => 0.42 },
);
