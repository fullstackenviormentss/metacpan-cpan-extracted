# -*- coding: utf-8 -*-
# Copyright (C) 2012, 2014-2015 Rocky Bernstein <rocky@cpan.org>
use warnings; no warnings 'redefine'; no warnings 'once';
use rlib '../../../../../..';

package Devel::Trepan::CmdProcessor::Command::Set::Debug::Except;
use Devel::Trepan::CmdProcessor::Command::Subcmd::Subsubcmd;

use strict;
use vars qw(@ISA @SUBCMD_VARS);
@ISA = qw(Devel::Trepan::CmdProcessor::Command::SetBoolSubsubcmd);
# Values inherited from parent

use vars @Devel::Trepan::CmdProcessor::Command::Subsubcmd::SUBCMD_VARS;

our $IN_LIST      = 1;
our $SHORT_HELP   = "Debug exceptions handled by debugger";
our $MIN_ABBREV   = length('ex');
use constant MAX_ARGS => 1;
=pod

=head2 Synopsis:

=cut

our $HELP         = <<'HELP';
=pod

B<set debug except> [B<on>|B<off>]

Debug exceptions handled by debugger. If "on"
or "off" is not given, "on" is assumed.

=head2 See also:

L<C<show debug except>|Devel::Trepan::CmdProcessor::Command::Show::Debug::Except>

=cut
HELP

unless (caller) {
  # Demo it.
  # require_relative '../../../mock'
  # name = File.basename(__FILE__, '.rb')

  # dbgr, set_cmd = MockDebugger::setup('set')
  # $max_cmd       = __PACKAGE__->new(dbgr.core.processor, $set_cmd)
  # $cmd_ary       = Trepan::SubSubcommand::SetMaxList::PREFIX
  # $cmd_name      = cmd_ary.join(' ')
  # $subcmd        = __PACKAGE__->new($set_cmd->{proc}, $max_cmd, $cmd_name);
  # $prefix_run = cmd_ary[1..-1]
  # $subcmd->run(prefix_run);
  # $subcmd-.run(prefix_run, qw(0));
  # $subcmd->run(prefix_run, qw(20));
  # $subcmd->summary_help(name);
  # print
  # print '-' x 20;
  # print $subcmd->save_command
}

1;
