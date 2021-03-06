# (X)Emacs mode: -*- cperl -*-

use strict;

=head1 Unit Test Package for Log::Info functions

This package tests the translator functionality of Log::Info

=cut

use Fatal                 qw( close open read seek );
use Fcntl                 qw( SEEK_END );
use File::Glob            qw( );
use File::Spec::Functions qw( catdir updir );
use FindBin               qw( $Bin );
use IO::Select            qw( );
use POSIX                 qw( tmpnam );
use Test::More            tests => 10, import => [qw( diag is like ok )];

use lib catdir $Bin, updir, 'lib';

# Channel names for playing with
use constant TESTCHAN1 => 'testchan1';
use constant TESTCHAN2 => 'testchan2';

# Sink names for playing with
use constant SINK1 => 'sink1';
use constant SINK2 => 'sink2';

# Message texts for playing with
# Tests rely on no "\n" in these
# Each message to be distinct for searching
use constant MESSAGE1   => 'Cuthbert';
use constant MESSAGE2   => 'Dibble';
use constant TIME       => time;
use constant MAXMESSLEN => ((length(MESSAGE1) > length(MESSAGE2)) ?
                            length(MESSAGE1) : length(MESSAGE2));

# File sizes for playing with
use constant MAXSIZE1 => 100;
use constant MAXSIZE2 => 80;

use constant MAXMAXSIZE => ((MAXSIZE1 > MAXSIZE2) ? MAXSIZE1 : MAXSIZE2);

# Translators
# TRANS1 adds 2 chars onto each message
# TRANS2 doubles the length of each message
# Each translator leaves the original message in place for searchability
#   (just add to 'em)
use constant TRANS1 => sub { "++$_[0]" };
use constant TRANS2 => sub { scalar(reverse($_[0])) . $_[0] };

use constant TMPNAM1 => tmpnam;
use constant TMPNAM2 => tmpnam;

use Log::Info qw( :DEFAULT :log_levels );

=head2 Test 1: compilation

This test confirms that the test script and the modules it calls compiled
successfully.

The C<:DEFAULT> and C<:log_levels> tags are passed to the C<use> call for
C<Log::Info>.

=cut

is 1, 1, 'compilation';

# ----------------------------------------------------------------------------

=head2 Test 2: set up channel and listener

Set up channel TESTCHAN1.  Set up listener.  Send MESSAGE1 to channel (level
0).

Same again for TESTCHAN2.

test no exception thrown

=cut

my @messages;

{
  my $ok = 0;

  eval {
    Log::Info::add_channel(TESTCHAN1);
    Log::Info::add_sink   (TESTCHAN1, SINK1, 'SUBR', undef,
                           { subr => sub { push @messages, $_[0] } });
    Log(TESTCHAN1, 0, MESSAGE1);

    Log::Info::add_channel(TESTCHAN2);
    Log::Info::add_sink   (TESTCHAN2, SINK1, 'SUBR', undef,
                           { subr => sub { push @messages, $_[0] } });
    Log(TESTCHAN2, 0, MESSAGE2);

    $ok = 1;
  }; if ( $@ ) {
    print STDERR "Test failed:\n$@\n"
      if $ENV{TEST_DEBUG};
    $ok = 0;
  }

  is $ok, 1, 'set up channel and listener';
}

=head2 Test 3: test log message received (TESTCHAN1)

=cut

is $messages[0], MESSAGE1, 'test log message received (TESTCHAN1)';

=head2 Test 4: test log message received (TESTCHAN2)

=cut

is $messages[1], MESSAGE2, 'test log message received (TESTCHAN2)';
@messages = ();

# ----------------------------------------------------------------------------

=head2 Test 5: TRANS_UDT

Add a channel translator to TESTCHAN1.  Log a message.

Test message logged is what is expected after channel translation.

=cut

my $trans_udt_name;

{
  my $ok = 0;

  @messages = ();
  my $trans_udt_name =
    Log::Info::add_chan_trans(TESTCHAN1, Log::Info::TRANS_UDT);
  Log(TESTCHAN1, 0, MESSAGE1);
  Log::Info::remove_chan_trans(TESTCHAN1, $trans_udt_name);
  Log(TESTCHAN1, 0, MESSAGE1);

  is 0+ @messages, 2;
  diag "TRANS_UDT: $messages[0]"
    if $ENV{TEST_DEBUG};
  like $messages[0], qr/^\[\d+\ \w{3}\ \w{3}\ {1,2}\d{1,2}
                        \ \d{1,2}:\d{2}:\d{2}\ \d{4}\]
                        \ @{[MESSAGE1]}$/x, 'TRANS_UDT';
  is $messages[1], MESSAGE1;
  @messages = ();
}

# -------------------------------------

=head2 Test 6: TRANS_CDT

Add a channel translator to TESTCHAN2.  Log a message.

Test message logged is what is expected after channel translation.

=cut

{
  my $ok = 0;

  @messages = ();

  my $trans_cdt_name = 'Barney Mcgrew';
  Log::Info::add_chan_trans(TESTCHAN2, Log::Info::TRANS_CDT, $trans_cdt_name);
  Log(TESTCHAN2, 0, MESSAGE2);
  Log::Info::remove_chan_trans(TESTCHAN2, $trans_cdt_name);
  Log(TESTCHAN2, 0, MESSAGE2);

  is 0+ @messages, 2;
  diag "TRANS_CDT: $messages[0]"
    if $ENV{TEST_DEBUG};
  like $messages[0], qr/^\[\d+\(\d{1,2}\w{3}\ \d{1,2}:\d{1,2}(?::\d{1,2})?
                         [+-]\d+\):$0\]
                         \ @{[MESSAGE2]}$/x, 'TRANS_CDT';
  is $messages[1], MESSAGE2;
  @messages = ();
}

# -------------------------------------
