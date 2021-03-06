# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl PGHandler.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { 
        use_ok('CGI::Carp');
        use_ok('CGI::Util');
        use_ok('Class::Struct');
        use_ok('DBD::mysql');
        use_ok('DBI');
      };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

