# Note: this file was auto-generated by Module::Build::Compat version 0.33
use ExtUtils::MakeMaker;
WriteMakefile
(
          'NAME' => 'ORDB::DebianModules::Generator',
          'VERSION_FROM' => 'lib/ORDB/DebianModules/Generator.pm',
          'PREREQ_PM' => {
                           'DBD::SQLite' => 0,
                           'DBI' => 0,
                           'Debian::ModuleList' => 0,
                           'Test::More' => 0
                         },
          'INSTALLDIRS' => 'site',
          'EXE_FILES' => [
                           'bin/generate-debian-modules-database.pl',
                           'bin/generate-debian-modules-database.pl~'
                         ],
          'PL_FILES' => {}
        )
;
