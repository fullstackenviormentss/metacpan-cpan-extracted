# Note: this file was auto-generated by Module::Build::Compat version 0.03
use ExtUtils::MakeMaker;
WriteMakefile
(
          'NAME' => 'Net::FS::Gmail',
          'VERSION_FROM' => 'lib/Net/FS/Gmail.pm',
          'PREREQ_PM' => {
                           'File::Basename' => '0',
                           'Mail::Webmail::Gmail' => '1.05.1',
                           'Test::More' => '0',
                           'Time::ParseDate' => '0',
                           'URI::Escape' => '0'
                         },
          'INSTALLDIRS' => 'site',
          'EXE_FILES' => [
                           'bin/gmailfs'
                         ],
          'PL_FILES' => {}
        )
;
