use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME'           => 'CGI::LogCarp',
	'DISTNAME'       => 'LogCarp',
	'VERSION_FROM'   => 'LogCarp.pm', # Finds $VERSION
    'dist'           => { 'COMPRESS' => 'gzip', 'SUFFIX' => '.gz' }
);
