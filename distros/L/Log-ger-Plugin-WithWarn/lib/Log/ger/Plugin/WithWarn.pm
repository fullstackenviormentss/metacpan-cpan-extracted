package Log::ger::Plugin::WithWarn;

our $DATE = '2017-08-04'; # DATE
our $VERSION = '0.002'; # VERSION

use strict;
use warnings;

use Log::ger ();

sub get_hooks {
    my %conf = @_;

    return {
        create_routine_names => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $levels = \%Log::ger::Levels;

                return [{
                    log_subs    => [
                        (map { ["log_${_}_warn", $_, "default"] }
                             grep {$levels->{$_} == 30} keys %$levels),
                    ],
                    is_subs     => [],
                    log_methods => [
                        (map { ["${_}_warn", $_, "default"] }
                             grep {$levels->{$_} == 30} keys %$levels),
                    ],
                    logml_methods => [
                    ],
                    is_methods  => [
                    ],
                }, 0];
            }],
        before_install_routines => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                # wrap the logger
                for my $r (@{ $args{routines} }) {
                    my ($code, $name, $numlevel, $type) = @$r;
                    if ($type eq 'log_sub' && $name =~ /\Alog_\w+_warn\z/) {
                        $r->[0] = sub {
                            $code->(@_);
                            warn $args{formatters}{default}(@_)."\n"
                        };
                    } elsif ($type eq 'log_method' && $name =~ /\A\w+_warn\z/) {
                        $r->[0] = sub {
                            $code->(@_);
                            shift;
                            warn $args{formatters}{default}(@_)."\n"
                        };
                    }
                }
            },
        ],
    };
}

1;
# ABSTRACT: Add *_warn logging routines

__END__

=pod

=encoding UTF-8

=head1 NAME

Log::ger::Plugin::WithWarn - Add *_warn logging routines

=head1 VERSION

version 0.002

=head1 SYNOPSIS

 use Log::ger::Plugin 'WithWarn';
 use Log::ger;
 my $log = Log::ger->get_logger;

These subroutines will also become available:

 log_warn_warn("blah!"); # in addition to log, will also warn()

These logging methods will also become available:

 $log->warn_warn("blah!"); # in addition to log, will also warn()

=head1 DESCRIPTION

=for Pod::Coverage ^(.+)$

=head1 SEE ALSO

L<Log::ger::Plugin::WithDie>

L<Log::ger::Plugin::WithCarp>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
