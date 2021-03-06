use 5.020002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::Ethereum::Swarm',
    VERSION_FROM      => 'lib/Net/Ethereum/Swarm.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {
      "HTTP::Request" => 0,
      "LWP::UserAgent" => 0,
      "JSON" => 0,
      "File::Slurp" => 0
    }, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Net/Ethereum/Swarm.pm', # retrieve abstract from module
    AUTHOR            => 'A. U. Thor <ethertest@>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
