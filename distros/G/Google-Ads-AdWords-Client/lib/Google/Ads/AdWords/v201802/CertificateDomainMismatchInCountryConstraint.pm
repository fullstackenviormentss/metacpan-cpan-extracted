package Google::Ads::AdWords::v201802::CertificateDomainMismatchInCountryConstraint;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'https://adwords.google.com/api/adwords/cm/v201802' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}


use base qw(Google::Ads::AdWords::v201802::CountryConstraint);
# Variety: sequence
use Class::Std::Fast::Storable constructor => 'none';
use base qw(Google::Ads::SOAP::Typelib::ComplexType);

{ # BLOCK to scope variables

my %constraintType_of :ATTR(:get<constraintType>);
my %PolicyTopicConstraint__Type_of :ATTR(:get<PolicyTopicConstraint__Type>);
my %constrainedCountries_of :ATTR(:get<constrainedCountries>);
my %totalTargetedCountries_of :ATTR(:get<totalTargetedCountries>);

__PACKAGE__->_factory(
    [ qw(        constraintType
        PolicyTopicConstraint__Type
        constrainedCountries
        totalTargetedCountries

    ) ],
    {
        'constraintType' => \%constraintType_of,
        'PolicyTopicConstraint__Type' => \%PolicyTopicConstraint__Type_of,
        'constrainedCountries' => \%constrainedCountries_of,
        'totalTargetedCountries' => \%totalTargetedCountries_of,
    },
    {
        'constraintType' => 'Google::Ads::AdWords::v201802::PolicyTopicConstraint::PolicyTopicConstraintType',
        'PolicyTopicConstraint__Type' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'constrainedCountries' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
        'totalTargetedCountries' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    },
    {

        'constraintType' => 'constraintType',
        'PolicyTopicConstraint__Type' => 'PolicyTopicConstraint.Type',
        'constrainedCountries' => 'constrainedCountries',
        'totalTargetedCountries' => 'totalTargetedCountries',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Google::Ads::AdWords::v201802::CertificateDomainMismatchInCountryConstraint

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CertificateDomainMismatchInCountryConstraint from the namespace https://adwords.google.com/api/adwords/cm/v201802.

Information about countries that were targeted, but the certificate for those countries does not include the correct domain. 




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over



=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():






=head1 AUTHOR

Generated by SOAP::WSDL

=cut

