# ABSTRACT: Integer Object for Perl 5
package Data::Object::Integer;

use strict;
use warnings;

use 5.014;

use Data::Object;
use Data::Object::Class;
use Data::Object::Library;
use Data::Object::Signatures;
use Scalar::Util;

with 'Data::Object::Role::Integer';

our $VERSION = '0.59'; # VERSION

method new ($class: @args) {

    my $arg  = $args[0];
    my $role = 'Data::Object::Role::Type';

    $arg = $arg->data if Scalar::Util::blessed($arg)
        and $arg->can('does')
        and $arg->does($role);

    $arg =~ s/^\+//; # not keen on this but ...

    Data::Object::throw('Type Instantiation Error: Not an Integer')
        unless defined($arg) && !ref($arg) && Scalar::Util::looks_like_number($arg);

    $arg += 0 unless $arg =~ /[a-zA-Z]/;

    return bless \$arg, $class;

}

our @METHODS = @{ __PACKAGE__->methods };

my  $exclude = qr/^data|detract|new$/;

around [ grep { !/$exclude/ } @METHODS ] => fun ($orig, $self, @args) {

    my $results = $self->$orig(@args);

    return Data::Object::deduce_deep($results);

};

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Object::Integer - Integer Object for Perl 5

=head1 VERSION

version 0.59

=head1 SYNOPSIS

    use Data::Object::Integer;

    my $integer = Data::Object::Integer->new(9);

=head1 DESCRIPTION

Data::Object::Integer provides routines for operating on Perl 5 integer
data. Integer methods work on data that meets the criteria for being an integer.
An integer holds and manipulates an arbitrary sequence of bytes, typically
representing numeric characters. Users of integers should be aware of the
methods that modify the integer itself as opposed to returning a new integer.
Unless stated, it may be safe to assume that the following methods copy, modify
and return new integers based on their function.

=head1 COMPOSITION

This package inherits all functionality from the L<Data::Object::Role::Integer>
role and implements proxy methods as documented herewith.

=head1 METHODS

=head2 data

    # given $integer

    $integer->data; # original value

The data method returns the original and underlying value contained by the
object. This method is an alias to the detract method.

=head2 defined

    # given $integer

    $integer->defined; # 1

The defined method returns true if the object represents a value that meets the
criteria for being defined, otherwise it returns false. This method returns a
L<Data::Object::Number> object.

=head2 detract

    # given $integer

    $integer->detract; # original value

The detract method returns the original and underlying value contained by the
object.

=head2 downto

    # given 1

    $integer->downto(0); # [1,0]

The downto method returns an array reference containing integer decreasing
values down to and including the limit. This method returns a
L<Data::Object::Array> object.

=head2 dump

    # given 1

    $integer->dump; # '1'

The dump method returns returns a string representation of the object.
This method returns a L<Data::Object::String> object.

=head2 eq

    # given 1

    $integer->eq(1); # 1

The eq method performs a numeric equality operation. This method returns a
L<Data::Object::Number> object representing a boolean.

=head2 ge

    # given 1

    $integer->ge(0); # 1

The ge method returns true if the argument provided is greater-than or equal-to
the value represented by the object. This method returns a Data::Object::Number
object.

=head2 gt

    # given 1

    $integer->gt(1); # 0

The gt method performs a numeric greater-than comparison. This method returns a
L<Data::Object::Number> object representing a boolean.

=head2 le

    # given 0

    $integer->le(1); # 1

The le method returns true if the argument provided is less-than or equal-to
the value represented by the object. This method returns a Data::Object::Number
object.

=head2 lt

    # given 1

    $integer->lt(1); # 0

The lt method performs a numeric less-than comparison. This method returns a
L<Data::Object::Number> object representing a boolean.

=head2 methods

    # given $integer

    $integer->methods;

The methods method returns the list of methods attached to object. This method
returns a L<Data::Object::Array> object.

=head2 ne

    # given 1

    $integer->ne(0); # 1

The ne method performs a numeric equality operation. This method returns a
L<Data::Object::Number> object representing a boolean.

=head2 new

    # given 9

    my $integer = Data::Object::Integer->new(9);

The new method expects a number and returns a new class instance.

=head2 print

    # given 0

    $integer->print; # '0'

The print method outputs the value represented by the object to STDOUT and
returns true. This method returns a L<Data::Object::Number> object.

=head2 roles

    # given $integer

    $integer->roles;

The roles method returns the list of roles attached to object. This method
returns a L<Data::Object::Array> object.

=head2 say

    # given 0

    $integer->say; # '0\n'

The say method outputs the value represented by the object appended with a
newline to STDOUT and returns true. This method returns a L<Data::Object::Number>
object.

=head2 throw

    # given $integer

    $integer->throw;

The throw method terminates the program using the core die keyword, passing the
object to the L<Data::Object::Exception> class as the named parameter C<object>.
If captured this method returns a L<Data::Object::Exception> object.

=head2 to

    # given 1

    $integer->to(2); # [1,2]
    $integer->to(0); # [1,0]

The to method returns an array reference containing integer increasing or
decreasing values to and including the limit in ascending or descending order
based on the value of the floating-point object. This method returns a
L<Data::Object::Array> object.

=head2 type

    # given $integer

    $integer->type; # INTEGER

The type method returns a string representing the internal data type object name.
This method returns a L<Data::Object::String> object.

=head2 upto

    # given 1

    $integer->upto(2); # [1,2]

The upto method returns an array reference containing integer increasing
values up to and including the limit. This method returns a
L<Data::Object::Array> object.

=head1 ROLES

This package is comprised of the following roles.

=over 4

=item *

L<Data::Object::Role::Comparison>

=item *

L<Data::Object::Role::Defined>

=item *

L<Data::Object::Role::Detract>

=item *

L<Data::Object::Role::Dumper>

=item *

L<Data::Object::Role::Item>

=item *

L<Data::Object::Role::Numeric>

=item *

L<Data::Object::Role::Output>

=item *

L<Data::Object::Role::Throwable>

=item *

L<Data::Object::Role::Type>

=item *

L<Data::Object::Role::Value>

=back

=head1 SEE ALSO

=over 4

=item *

L<Data::Object::Array>

=item *

L<Data::Object::Class>

=item *

L<Data::Object::Class::Syntax>

=item *

L<Data::Object::Code>

=item *

L<Data::Object::Float>

=item *

L<Data::Object::Hash>

=item *

L<Data::Object::Integer>

=item *

L<Data::Object::Number>

=item *

L<Data::Object::Role>

=item *

L<Data::Object::Role::Syntax>

=item *

L<Data::Object::Regexp>

=item *

L<Data::Object::Scalar>

=item *

L<Data::Object::String>

=item *

L<Data::Object::Undef>

=item *

L<Data::Object::Universal>

=item *

L<Data::Object::Autobox>

=item *

L<Data::Object::Immutable>

=item *

L<Data::Object::Library>

=item *

L<Data::Object::Prototype>

=item *

L<Data::Object::Signatures>

=back

=head1 AUTHOR

Al Newkirk <anewkirk@ana.io>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Al Newkirk.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
