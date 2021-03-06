# YASF - Yet Another String Formatter

## What Is It

YASF is a string formatter module for Perl that closely emulates the
functionality of Python's `%` string operator and `format()` string method.
In some ways it does less than the Python functionality, in other ways it does
more.

As YASF is a class (rather than a direct extension to Perl's strings), it can
store a set of bindings directly on the object. With object-level bindings, the
`format` method can produce a string without the explicit bindings argument.
This allows stringification to be overloaded, which means using a YASF object
in a context where it would be evaluated as a string will automatically format
it when object-level bindings are present. Otherwise, stringification will
just yield the unformatted template string.

YASF is intended to be very light-weight and (currently) uses only core Perl
modules.

## Using YASF

YASF is simple to use (or should be):

```perl
use YASF;

my $str = YASF->new("Hello {name}. How is life on {planet}?\n");

print $str % { name => 'John', planet => 'Earth' };
# Prints "Hello John. How is life on Earth?"
print $str->format({ planet => 'Zorblax-7', name => 'Zzcdefrgh' });
# Prints "Hello Zzcdefrgh. How is life on Zorblax-7?"
```

You can also use array references and numbered indices:

```perl
my $str = YASF->new("File at inode {1} has size {7} in bytes.\n");

for my $file (@file_list) {
    print $str % [ stat $file ];
}
```

Object references can be used also, in which case the key is called as a method
with no arguments:

```perl
use File::stat;

my $str = YASF->new("File at inode {ino} has size {size} in bytes.\n");

for my $file (@file_list) {
    print $str % stat($file);
}
```

Finally, keys can be chained together by `.` characters to traverse complex
data structures:

```perl
my $str = YASF->new(
    "{person.fname} {person.lname} is {person.age} years old.\n"
);
my $person = { fname => 'Randy', lname => 'Ray', age => 48 };

print $str % { person => $person };
```

## Building and Installing

This module builds and installs in the typical Perl fashion:

```
perl Makefile.PL
make && make test
```

If all tests pass, you install with:

```
make install
```

You may need super-user privileges to install.

## Problems and Bug Reports

Please report any problems or bugs to either the Perl RT or GitHub Issues:

* [Perl RT queue for YASF](http://rt.cpan.org/Public/Dist/Display.html?Queue=YASF)
* [GitHub Issues for YASF](https://github.com/rjray/yasf/issues)
