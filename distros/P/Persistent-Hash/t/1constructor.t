# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
plan tests => 1;

use strict;
use Persistent::Hash;
use Persistent::Hash::TestHash;

my $phash = Persistent::Hash::TestHash->new();
if(defined $phash)
{
	ok(1);
}
else { ok(0); }

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

