package Bio::Biblio::PubmedArticle;
BEGIN {
  $Bio::Biblio::PubmedArticle::AUTHORITY = 'cpan:BIOPERLML';
}
{
  $Bio::Biblio::PubmedArticle::VERSION = '1.70';
}
use utf8;
use strict;
use warnings;

use parent qw(Bio::Biblio::MedlineArticle);

# ABSTRACT: representation of a PUBMED article
# AUTHOR:   Martin Senger <senger@ebi.ac.uk>
# OWNER:    2002 European Bioinformatics Institute
# LICENSE:  Perl_5


our @ISA;
#
# a closure with a list of allowed attribute names (these names
# correspond with the allowed 'get' and 'set' methods); each name also
# keep what type the attribute should be (use 'undef' if it is a
# simple scalar)
#
{
    my %_allowed =
        (
         _pubmed_status => undef,
         _pubmed_provider_id => undef,
         _pubmed_history_list => 'ARRAY',
         _pubmed_article_id_list => 'ARRAY',
         _pubmed_url_list => 'ARRAY',
         );

    # return 1 if $attr is allowed to be set/get in this class
    sub _accessible {
        my ($self, $attr) = @_;
        return 1 if exists $_allowed{$attr};
        foreach my $parent (@ISA) {
            return 1 if $parent->_accessible ($attr);
        }
    }

    # return an expected type of given $attr
    sub _attr_type {
        my ($self, $attr) = @_;
        if (exists $_allowed{$attr}) {
            return $_allowed{$attr};
        } else {
            foreach my $parent (@ISA) {
                if ($parent->_accessible ($attr)) {
                    return $parent->_attr_type ($attr);
                }
            }
        }
        return 'unknown';
    }
}

1;

__END__
=pod

=encoding utf-8

=head1 NAME

Bio::Biblio::PubmedArticle - representation of a PUBMED article

=head1 VERSION

version 1.70

=head1 SYNOPSIS

    $obj = Bio::Biblio::PubmedArticle->new
                  (-pubmed_history_list =>
                       [ { 'pub_status' => 'pubmed',
                           'date' => '2001-12-1T10:0:00Z' },
                         { 'pub_status' => 'medline',
                           'date' => '2002-1-5T10:1:00Z' } ],
                   -pubmed_status => 'ppublish');
  #--- OR ---

    $obj = Bio::Biblio::PubmedArticle->new();
    $obj->pubmed_status ('ppublish');

=head1 DESCRIPTION

A storage object for a general PUBMED article.
See its place in the class hierarchy in
http://www.ebi.ac.uk/~senger/openbqs/images/bibobjects_perl.gif

=head2 Attributes

The following attributes are specific to this class
(however, you can also set and get all attributes defined in the parent classes):

  pubmed_status
  pubmed_provider_id
  pubmed_history_list       type: array ref of hashes
  pubmed_article_id_list    type: array ref of hashes
  pubmed_url_list           type: array ref of hashes

=head1 SEE ALSO

=over 4

=item *

OpenBQS home page

http://www.ebi.ac.uk/~senger/openbqs/

=item *

Comments to the Perl client

http://www.ebi.ac.uk/~senger/openbqs/Client_perl.html

=back

=head1 FEEDBACK

=head2 Mailing lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:
I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  https://redmine.open-bio.org/projects/bioperl/

=head1 LEGAL

=head2 Authors

Martin Senger <senger@ebi.ac.uk>

=head2 Copyright and License

This software is Copyright (c) by 2002 European Bioinformatics Institute and released under the license of the same terms as the perl 5 programming language system itself

=cut

