# -*- perl -*-
# DO NOT EDIT - This file is generated by UMMF; http://ummf.sourceforge.net 
# From template: $Id: Perl.txt,v 1.77 2006/05/14 01:40:03 kstephens Exp $

package UMMF::UML_1_5::Foundation::Core::Enumeration;

#use 5.6.1;
use strict;
use warnings;

#################################################################
# Version
#

our $VERSION = do { my @r = (q{1.5} =~ /\d+/g); sprintf "%d." . "%03d" x $#r, @r };


#################################################################
# Documentation
#

=head1 NAME

UMMF::UML_1_5::Foundation::Core::Enumeration -- 

=head1 VERSION

1.5

=head1 SYNOPSIS

=head1 DESCRIPTION 

=head1 USAGE

=head1 EXPORT

=head1 METATYPE

L<UMMF::UML_1_5::Foundation::Core::Class|UMMF::UML_1_5::Foundation::Core::Class>

=head1 SUPERCLASSES

L<UMMF::UML_1_5::Foundation::Core::DataType|UMMF::UML_1_5::Foundation::Core::DataType>




=head1 ATTRIBUTES

I<NO ATTRIBUTES>


=head1 ASSOCIATIONS


=head2 C<enumeration> : I<THIS> C<1> E<lt>---E<gt>  C<literal> : UMMF::UML_1_5::Foundation::Core::EnumerationLiteral C<1..*>



=over 4

=item metatype = L<UMMF::UML_1_5::Foundation::Core::AssociationEnd|UMMF::UML_1_5::Foundation::Core::AssociationEnd>

=item type = L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>

=item multiplicity = C<1..*>

=item changeability = C<changeable>

=item targetScope = C<instance>

=item ordering = C<ordered>

=item isNavigable = C<1>

=item aggregation = C<none>

=item visibility = C<public>

=item container_type = C<ARRAY>

=back



=head1 METHODS

=cut



#################################################################
# Dependencies
#





use Carp qw(croak confess);
use Set::Object 1.05;
use Class::Multimethods 1.70;
use Data::Dumper;
use Scalar::Util qw(weaken);
use UMMF::UML_1_5::__ObjectBase qw(:__ummf_array);


#################################################################
# Generalizations
#

use base qw(
  UMMF::UML_1_5::Foundation::Core::DataType



);


#################################################################
# Exports
#

our @EXPORT_OK = qw(
);
our %EXPORT_TAGS = ( 'all' => \@EXPORT_OK );





#################################################################
# Validation
#


=head2 C<__validate_type>

  UMMF::UML_1_5::Foundation::Core::Enumeration->__validate_type($value);

Returns true if C<$value> is a valid representation of L<UMMF::UML_1_5::Foundation::Core::Enumeration|UMMF::UML_1_5::Foundation::Core::Enumeration>.

=cut
sub __validate_type($$)
{
  my ($self, $x) = @_;

  no warnings;

  UNIVERSAL::isa($x, 'UMMF::UML_1_5::Foundation::Core::Enumeration')  ;
}


=head2 C<__typecheck>

  UMMF::UML_1_5::Foundation::Core::Enumeration->__typecheck($value, $msg);

Calls C<confess()> with C<$msg> if C<<UMMF::UML_1_5::Foundation::Core::Enumeration->__validate_type($value)>> is false.

=cut
sub __typecheck
{
  my ($self, $x, $msg) = @_;

  confess("typecheck: $msg: type '" . 'UMMF::UML_1_5::Foundation::Core::Enumeration' . ": value '$x'")
    unless __validate_type($self, $x);
}


=head2 C<isaEnumeration>


Returns true if receiver is a L<UMMF::UML_1_5::Foundation::Core::Enumeration|UMMF::UML_1_5::Foundation::Core::Enumeration>.
Other receivers will return false.

=cut
sub isaEnumeration { 1 }


=head2 C<isaFoundation__Core__Enumeration>


Returns true if receiver is a L<UMMF::UML_1_5::Foundation::Core::Enumeration|UMMF::UML_1_5::Foundation::Core::Enumeration>.
Other receivers will return false.
This is the fully qualified version of the C<isaEnumeration> method.

=cut
sub isaFoundation__Core__Enumeration { 1 }


#################################################################
# Introspection
#

=head2 C<__model_name> 

  my $name = $obj_or_package->__model_name;

Returns the UML Model name (C<'Foundation::Core::Enumeration'>) for an object or package of
this Classifier.

=cut
sub __model_name { 'Foundation::Core::Enumeration' }



=head2 C<__isAbstract>

  $package->__isAbstract;

Returns C<0>.

=cut
sub __isAbstract { 0; }


my $__tangram_schema;
=head2 C<__tangram_schema>

  my $tangram_schema $obj_or_package->__tangram_schema

Returns a HASH ref that describes this Classifier for Tangram.

See L<UMMF::Export::Perl::Tangram|UMMF::Export::Perl::Tangram>

=cut
sub __tangram_schema
{
  my ($self) = @_;

  $__tangram_schema ||=
  {
   'classes' =>
   [
     'UMMF::UML_1_5::Foundation::Core::Enumeration' =>
     {
       'table' => 'Foundation__Core__Enumeration',
       'abstract' => 0,
       'slots' => 
       { 
	 # Attributes
	 
	 # Associations
	 	 	       'literal'
       => {
	 'type_impl' => 'iarray',
         'class' => 'UMMF::UML_1_5::Foundation::Core::EnumerationLiteral',

                           'table' => 'Foundation__Core__Enumeration__literal', 

                                                               'coll' => 'enumeration',

                  'slot' => 'enumeration_i', 

                                                                      }
      ,
                         },
       'bases' => [  'UMMF::UML_1_5::Foundation::Core::DataType',  ],
       'sql' => {

       },
     },
   ],

   'sql' =>
   {
    # Note Tangram::Ref::get_exporter() has
    # "UPDATE $table SET $self->{col} = $refid WHERE id = $id",
    # The id_col is hard-coded, 
    # Thus id_col will not work.
    #'id_col' => '__sid',
    #'class_col' => '__stype',
   },
     # 'set_id' => sub { }
     # 'get_id' => sub { }

      
  };
}


#################################################################
# Class Attributes
#


    

#################################################################
# Class Associations
#


    

#################################################################
# Initialization
#


=head2 C<___initialize>

Initialize all Attributes and AssociationEnds in a instance of this Classifier.
Does B<not> initalize slots in its Generalizations.

See also: C<__initialize>.

=cut
sub ___initialize
{
  my ($self) = @_;

  # Attributes



  # Associations

  # AssociationEnd 
  #  enumeration 1
  #  <--> 
  #  literal 1..* UMMF::UML_1_5::Foundation::Core::EnumerationLiteral.
    if ( defined $self->{'literal'} ) {
    my $x = $self->{'literal'};
        $self->{'literal'} = [ ];
        $self->set_literal(@$x);
  }
  

  $self;
}


my $__initialize_use;

=head2 C<__initialize>

Initialize all slots in this Classifier and all its Generalizations.

See also: C<___initialize>.

=cut
sub __initialize
{
  my ($self) = @_;

  # $DB::single = 1;

  unless ( ! $__initialize_use ) {
    $__initialize_use = 1;
    $self->__use('UMMF::UML_1_5::Foundation::Core::Namespace');
    $self->__use('UMMF::UML_1_5::Foundation::Core::Element');
    $self->__use('UMMF::UML_1_5::Foundation::Core::ModelElement');
    $self->__use('UMMF::UML_1_5::Foundation::Core::GeneralizableElement');
    $self->__use('UMMF::UML_1_5::Foundation::Core::Classifier');
    $self->__use('UMMF::UML_1_5::Foundation::Core::DataType');
  }

  $self->UMMF::UML_1_5::Foundation::Core::Enumeration::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Namespace::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Element::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::GeneralizableElement::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::Classifier::___initialize;
  $self->UMMF::UML_1_5::Foundation::Core::DataType::___initialize;

  $self;
}
      

=head2 C<__create>

Calls all <<create>> Methods for this Classifier and all Generalizations.

See also: C<___create>.

=cut
sub __create
{
  my ($self, @args) = @_;

  # $DB::single = 1;
  $self->UMMF::UML_1_5::Foundation::Core::Enumeration::___create(@args);
  $self->UMMF::UML_1_5::Foundation::Core::Namespace::___create();
  $self->UMMF::UML_1_5::Foundation::Core::Element::___create();
  $self->UMMF::UML_1_5::Foundation::Core::ModelElement::___create();
  $self->UMMF::UML_1_5::Foundation::Core::GeneralizableElement::___create();
  $self->UMMF::UML_1_5::Foundation::Core::Classifier::___create();
  $self->UMMF::UML_1_5::Foundation::Core::DataType::___create();

  $self;
}




#################################################################
# Attributes
#




#################################################################
# Association
#


=for html <hr/>

=cut

#################################################################
# AssociationEnd enumeration <---> literal
# type = UMMF::UML_1_5::Foundation::Core::EnumerationLiteral
# multiplicity = 1..*
# ordering = ordered

=head2 C<literal>

  my @val = $obj->literal;
  my $ary_val = $obj->literal;

Returns the AssociationEnd C<literal> values of type L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
In array context, returns all the objects in the Association.
In scalar context, returns an array ref of all the objects in the Association.

=cut
sub literal ($)
{
  my ($self) = @_;

    my $x = $self->{'literal'} ||= [ ];

  wantarray ? @{$x} : $x;
  
}


=head2 C<index_literal>

  my $x = $obj->index_literal($i);
  my @x = $obj->index_literal($i, $count);

In scalar context, returns the value of AssociationEnd C<literal> at index C<$i>.
In array context, returns the values between index C<$i> and C<$i + $count - 1>, inclusive.

=cut
sub index_literal ($$@)
{
  my ($self, $i, $count) = @_;

  ;

  my $val = $self->{'literal'} ||= [ ];

  ;

  wantarray ? $val->[$i .. (defined $count ? $i + $count - 1 : $i)]
            : $val->[$i];
}


=head2 C<index_of_literal>

  my $index = $obj->index_of_literal($val);

Returns the index of C<$val> in AssociationEnd C<literal>.
Return C<undef> if C<$val> is not in C<literal>.

=cut
sub index_of_literal ($$)
{
  my ($self, $x) = @_;

  ;

  my $val = $self->{'literal'} ||= [ ];

  ;

  __ummf_array_index($val, $x);
}


=head2 C<set_literal>

  $obj->set_literal(@val);

Sets the AssociationEnd C<literal> value.
Elements of C<@val> must of type L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
Returns C<$obj>.

=cut
sub set_literal ($@)
{
  my ($self, @val) = @_;
  
  $self->clear_literal;
  $self->add_literal(@val);
}


=head2 C<set_index_literal>

  $obj->set_index_literal($i, $val);

Sets the value of AssociationEnd C<literal> at index C<$i>.
Returns self.

=cut
sub set_index_literal ($$$)
{
  my ($self, $i, $val) = @_;

  ;

  my $x = $self->{'literal'} ||= [ ];

  no warnings;
  my $old;
  if ( ($old = $x->[$i]) ne $val) {
    # Recursion lock
        $x->[$i] = $val
    ;

    # Remove and add associations with other ends.
        
    $old->remove_enumeration($self) if $old;
    $val->add_enumeration($self)    if $val;

  
    ;
  }

  $self;
}


=head2 C<add_literal>

  $obj->add_literal(@val);

Adds AssociationEnd C<literal> values.
Elements of C<@val> must of type L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
Returns C<$obj>.

=cut
sub add_literal ($@)
{
  my ($self, @val) = @_;
  
    my $x = $self->{'literal'} ||= [ ];
    my $old; # Place holder for other MACRO.
  
  for my $val ( @val ) {
    # Recursion lock
        next if grep($_ eq $val, @$x);
        $self->__use('UMMF::UML_1_5::Foundation::Core::EnumerationLiteral')->__typecheck($val, "UMMF::UML_1_5::Foundation::Core::Enumeration.literal");

    # Recursion lock
        push(@{$x}, $val);
        
    # Remove and add associations with other ends.
        
    $old->remove_enumeration($self) if $old;
    $val->add_enumeration($self)    if $val;

    }
  
  $self;
}


=head2 C<add_index_literal>

  $obj->add_index_literal($i, @val);

Adds AssociationEnd C<literal> values at index C<$i>.
Elements of C<@val> must of type L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
Returns C<$obj>.

=cut
sub add_index_literal ($$@)
{
  my ($self, $i, @val) = @_;

  
    my $x = $self->{'literal'} ||= [ ];
    my $old; # Place holder for other MACRO.
  
  for my $val ( @val ) {
    # Recursion lock
        next if grep($_ eq $val, @$x);
        $self->__use('UMMF::UML_1_5::Foundation::Core::EnumerationLiteral')->__typecheck($val, "UMMF::UML_1_5::Foundation::Core::Enumeration.literal");

    # Recursion lock
        splice(@{$x}, $i, 0, $val); # Recursion lock
        ++ $i;
    
    # Remove and add associations with other ends.
        
    $old->remove_enumeration($self) if $old;
    $val->add_enumeration($self)    if $val;

    }
  
  
  $self;
}


=head2 C<remove_literal>

  $obj->remove_literal(@val);

Removes the AssociationEnd C<literal> values C<@val>.
Elements of C<@val> must of type L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
Returns C<$obj>.

=cut
sub remove_literal ($@)
{
  my ($self, @val) = @_;
  
    my $x = $self->{'literal'} ||= [ ];
  
  for my $old ( @val ) {
    # Recursion lock
        my $i; # index of $old in @$x.
    next unless defined($i = __ummf_array_index($x, $old));
    
    my $val = $old;
      
    $self->__use('UMMF::UML_1_5::Foundation::Core::EnumerationLiteral')->__typecheck($val, "UMMF::UML_1_5::Foundation::Core::Enumeration.literal");

    # Recursion lock
        splice(@$x, $i, 1);     
    $val = undef;

    # Remove associations with other ends.

        
    $old->remove_enumeration($self) if $old;
    $val->add_enumeration($self)    if $val;

  ;

  }
  
  $self;
}


=head2 C<clear_literal>

  $obj->clear_literal;

Clears the AssociationEnd C<literal> links to L<UMMF::UML_1_5::Foundation::Core::EnumerationLiteral|UMMF::UML_1_5::Foundation::Core::EnumerationLiteral>.
Returns C<$obj>.

=cut
sub clear_literal ($) 
{
  my ($self) = @_;
  
    my $x = $self->{'literal'} ||= [ ];
  
  my $val; # Place holder for other MACRO.
  
    $self->{'literal'} = [ ];  # Recursion lock
  for my $old ( @$x ) { # Recursion lock
  
    # Remove associations with other ends.

        
    $old->remove_enumeration($self) if $old;
    $val->add_enumeration($self)    if $val;

  ;

  }
  
  $self;
}


=head2 C<count_literal>

  $obj->count_literal;

Returns the number of elements associated with C<literal>.

=cut
sub count_literal ($)
{
  my ($self) = @_;

  my $x = $self->{'literal'};

    defined $x ? scalar @$x : 0;
  }







# End of Class Enumeration


=pod

=for html <hr/>

I<END OF DOCUMENT>

=cut

############################################################################

1; # is true!

############################################################################

### Keep these comments at end of file: kstephens@users.sourceforge.net 2003/04/06 ###
### Local Variables: ###
### mode:perl ###
### perl-indent-level:2 ###
### perl-continued-statement-offset:0 ###
### perl-brace-offset:0 ###
### perl-label-offset:0 ###
### End: ###

