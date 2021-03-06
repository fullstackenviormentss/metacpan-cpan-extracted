package App::GitGot::Command::mux;
our $AUTHORITY = 'cpan:GENEHACK';
$App::GitGot::Command::mux::VERSION = '1.336';
# ABSTRACT: open a tmux window for a selected project
use 5.014;

use IO::Prompt::Simple;

use App::GitGot -command;

use Moo;
extends 'App::GitGot::Command';
use namespace::autoclean;

sub command_names { qw/ mux tmux / }

sub options {
  my( $class , $app ) = @_;
  return (
    [ 'dirty|D'   => 'open session or window for all dirty repos' ] ,
    [ 'exec|e=s'  => 'pass a command to the `tmux new-window` command (not valid in combination with -s option)'] ,
    [ 'session|s' => 'use tmux-sessions (default: tmux windows)' ] ,
  );
}

sub _use_io_page { 0 }

sub _execute {
  my( $self, $opt, $args ) = @_;

  die "-e and -s are mutually exclusive"
    if $self->opt->exec and $self->opt->session;

  my @repos = $self->opt->dirty ? $self->_get_dirty_repos() : $self->active_repos();

  my $target = $self->opt->session ? 'session' : 'window';

  if ( @repos >= 25 ) {
    my $repo_count = scalar @repos;
    return unless
      prompt( "\nYou're about to open $repo_count ${target}s - you sure about that? ", { yn => 1, default => 'n' } );
  }

 REPO: foreach my $repo ( @repos ) {
    # is it already opened?
    my %windows = reverse map { /^(\d+):::(\S+)/ }
      split "\n", `tmux list-$target -F"#I:::#W"`;

    if( my $window = $windows{$repo->name} ) {
      if ($self->opt->session) {
        system 'tmux', 'switch-client', '-t' => $window;
      }
      else {
        system 'tmux', 'select-window', '-t' => $window;
      }
      next REPO;
    }

    chdir $repo->path;

    if ($self->opt->session) {
      delete local $ENV{TMUX};
      system 'tmux', 'new-session', '-d', '-s', $repo->name;
      system 'tmux', 'switch-client', '-t' => $repo->name;}
    else {
      my @args = (qw/ tmux new-window -n / , $repo->name );
      push( @args , $self->opt->exec ) if $self->opt->exec;
      system @args;
    }
  }
}

sub _get_dirty_repos {
  my $self = shift;

  my @dirty_repos;
  foreach my $repo ( @{ $self->full_repo_list } ) {
    my $status = $repo->status();

    unless ( ref( $status )) {
      die "You need at least Git version 1.7 to use the --dirty flag.\n";
    }

    push @dirty_repos , $repo
      if $status->is_dirty;
  }

  return @dirty_repos;
}

1;

## FIXME docs

__END__

=pod

=encoding UTF-8

=head1 NAME

App::GitGot::Command::mux - open a tmux window for a selected project

=head1 VERSION

version 1.336

=head1 AUTHOR

John SJ Anderson <genehack@genehack.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by John SJ Anderson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
