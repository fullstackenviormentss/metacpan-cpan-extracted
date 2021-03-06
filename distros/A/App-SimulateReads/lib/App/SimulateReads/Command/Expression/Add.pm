package App::SimulateReads::Command::Expression::Add;
# ABSTRACT: expression subcommand class. Add an expression-matrix to the database.

use App::SimulateReads::Base 'class';

extends 'App::SimulateReads::Command::Expression';

our $VERSION = '0.16'; # VERSION

override 'opt_spec' => sub {
	super,
	'verbose|v',
	'expression-matrix|f=s',
	'source|s=s'
};

sub _default_opt {
	'verbose' => 0,
	'source'  => 'not defined'
}

sub validate_args {
	my ($self, $args) = @_;
	my $file = shift @$args;

	# Mandatory file
	if (not defined $file) {
		die "Missing an expression-matrix file\n";
	}

	# Is it really a file?
	if (not -f $file) {
		die "'$file' is not a file. Please, give me a valid expression-matrix file\n";
	}

	die "Too many arguments: '@$args'\n" if @$args;
}

sub validate_opts {
	my ($self, $opts) = @_;
	my %default_opt = $self->_default_opt;
	$self->fill_opts($opts, \%default_opt);

	if (not exists $opts->{'expression-matrix'}) {
		die "Mandatory option 'expression-matrix' not defined\n";
	}
}

sub execute {
	my ($self, $opts, $args) = @_;
	my $file = shift @$args;

	my %default_opt = $self->_default_opt;
	$self->fill_opts($opts, \%default_opt);

	# Set if user wants a verbose log
	$LOG_VERBOSE = $opts->{verbose};

	# Go go go
	log_msg ":: Inserting $opts->{'expression-matrix'} from $file ...";
	$self->insertdb(
		$file,
		$opts->{'expression-matrix'},
		$opts->{'source'},
		1
	);

	log_msg ":: Done!";
}

__END__

=pod

=encoding UTF-8

=head1 NAME

App::SimulateReads::Command::Expression::Add - expression subcommand class. Add an expression-matrix to the database.

=head1 VERSION

version 0.16

=head1 SYNOPSIS

 simulate_reads expression add -f <entry name> [-s <source>] FILE

 Arguments:
  an expression-matrix file

 Mandatory options:
  -f, --expression-matrix    an expression-matrix entry

 Options:
  -h, --help                 brief help message
  -M, --man                  full documentation
  -v, --verbose              print log messages
  -s, --source               expression-matrix source detail for database

=head1 DESCRIPTION

B<simulate_reads> will read the given input file and do something
useful with the contents thereof.

=head1 OPTIONS

=over 8

=item B<--expression-matrix>

A valid expression-matrix is a file with 2 columns. The first column is for the seqid
and the second column is for the count. The counts will be treated as weights

=back

=head1 AUTHOR

Thiago L. A. Miller <tmiller@mochsl.org.br>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Teaching and Research Institute from Sírio-Libanês Hospital.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
