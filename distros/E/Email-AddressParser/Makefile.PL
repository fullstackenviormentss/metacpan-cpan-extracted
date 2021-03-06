use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Email::AddressParser',
    VERSION_FROM      => 'lib/Email/AddressParser.pm', # finds $VERSION
    PREREQ_PM         => {}, 
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Email/AddressParser.pm', 
       AUTHOR         => 'Anthony Kay <tkay@uoregon.edu>') : ()),
    LIBS              => [''], 
    DEFINE            => '', 
    INC               => '-I.', 
);
