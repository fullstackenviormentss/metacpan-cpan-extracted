use strict;
use Module::Build;
Module::Build->new(
    module_name => 'Email::Store::HTML',
    license     => 'perl',
    requires    =>    {
                         'perl' => 5.006,
                         'Email::Store' => 0,
                         'HTML::Scrubber' => 0,
                         'HTML::FormatText::WithLinks' => 0,
                      },
    build_requires => {
                         'Test::More' => 0,
                         'DBD::SQLite' => 0,
                      },
    create_makefile_pl => 'traditional',
)->create_build_script;
