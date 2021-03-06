use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Astro::FITS::CFITSIO::CheckStatus',
    'VERSION_FROM'	=> 'CheckStatus.pm', # finds $VERSION
    'PREREQ_PM'		=> {
			    Astro::FITS::CFITSIO => 0,
		            Scalar::Util => 0,
			   }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'CheckStatus.pm', # retrieve abstract from module
       AUTHOR     => 'Diab Jerius <djerius@cpan.org>') : ()),
);
