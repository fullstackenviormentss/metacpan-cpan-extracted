package Bio::Roary::External::Prank;
$Bio::Roary::External::Prank::VERSION = '3.12.0';
# ABSTRACT: Wrapper to run prank


use Moose;
use File::Spec;
with 'Bio::Roary::JobRunner::Role';

has 'input_filename'  => ( is => 'ro', isa => 'Str', required => 1 );
has 'output_filename' => ( is => 'ro', isa => 'Str', default  => 'output' );
has 'exec'            => ( is => 'ro', isa => 'Str', default  => 'prank' );

# Overload Role
has 'memory_in_mb' => ( is => 'ro', isa => 'Int', lazy => 1, builder => '_build_memory_in_mb' );

sub _build_memory_in_mb {
    my ($self) = @_;
    my $memory_required = 2000;
    return $memory_required;
}

sub _command_to_run {
    my ($self) = @_;

    if(! -e $self->input_filename)
	{
		$self->logger->error( "Input file to PRANK missing: " . $self->input_filename );
	}

    return join(
        ' ',
        (
            $self->exec,
            "-d=" . $self->input_filename,
            "-o=" . $self->output_filename,
            '-codon', '-F', '-quiet', '-once', '> /dev/null 2>&1',
            '&&', 'mv', $self->output_filename . '*.fas',
            $self->output_filename
        )
    );
}

sub run {
    my ($self) = @_;
    my @commands_to_run;

    push( @commands_to_run, $self->_command_to_run() );
    $self->logger->info( "Running command: " . $self->_command_to_run() );

    my $job_runner_obj = $self->_job_runner_class->new(
        commands_to_run => \@commands_to_run,
        memory_in_mb    => $self->memory_in_mb,
        queue           => $self->_queue,
        cpus            => $self->cpus
    );
    $job_runner_obj->run();

    1;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bio::Roary::External::Prank - Wrapper to run prank

=head1 VERSION

version 3.12.0

=head1 SYNOPSIS

Wrapper to run cd-hit
   use Bio::Roary::External::Prank;

	my $prank_obj = Bio::Roary::External::Prank->new(
	  input_filename  => $fasta_file,
	  output_filename => $fasta_file.'.aln',
	  job_runner      => 'Local'
	);
	$prank_obj->run();

=head1 AUTHOR

Andrew J. Page <ap13@sanger.ac.uk>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Wellcome Trust Sanger Institute.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
