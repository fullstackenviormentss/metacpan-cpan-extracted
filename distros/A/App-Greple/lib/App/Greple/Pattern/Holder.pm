package App::Greple::Pattern::Holder;

use strict;
use warnings;
use Data::Dumper;
use Carp;

use Exporter 'import';
our @EXPORT      = ();
our %EXPORT_TAGS = ();
our @EXPORT_OK   = qw();

use App::Greple::Pattern;

sub new {
    my $class = shift;
    my $obj = bless [], $class;
    $obj;
}

sub append {
    my $obj = shift;
    my $arg = ref $_[0] eq 'HASH' ? shift : {};

    return $obj unless @_;

    $arg->{type} //= 'pattern';

    if ($arg->{type} eq 'file') {
	$obj->load_file($arg, @_);
	return $obj;
    }

    if ($arg->{flag} & FLAG_LEXICAL) {
	for (@_) {
	    $obj->lexical_opt($arg, $_);
	}
	return $obj;
    }

    if ($arg->{flag} & FLAG_OR) {
	$arg->{flag} &= ~FLAG_OR;
	my @p = map {
	    App::Greple::Pattern->new
		($_, flag => $arg->{flag} & ~FLAG_IGNORECASE)
		->cooked;
	} @_;
	my $p = "(?x)\n" . join(" |\n", map { s/(\s)/\\$1/gr } @p);
	$arg->{flag} |= FLAG_REGEX;
	$arg->{flag} &= ~FLAG_COOK;
	push @$obj, App::Greple::Pattern->new($p, flag => $arg->{flag});
	return $obj;
    }

    for (@_) {
	push @$obj, App::Greple::Pattern->new($_, flag => $arg->{flag});
    }

    $obj;
}

sub lexical_opt {
    my($obj, $arg, $opt) = @_;

    unless ($arg->{flag} & FLAG_LEXICAL) {
	die "Unexpected flag value ($arg->{flag})";
    }
    my $orig_flag = $arg->{flag} & ~FLAG_LEXICAL;

    my @or;
    for (split /(?<!\\) +/, $opt) {

	next if $_ eq "";

	my $flag = $orig_flag;

	if (s/^\?//) {					# ?pattern
	    push @or, $_;
	    next;
	}
	elsif (s/^\+//) {				# +pattern
	    $flag |= FLAG_REGEX | FLAG_REQUIRED;
	}
	elsif (s/^-//) {				# -pattern
	    $flag |= FLAG_REGEX | FLAG_NEGATIVE;
	}
	elsif (s/^\&//) {				# &func(...)
	    $flag |= FLAG_FUNCTION;
	}
	else {						# else
	    $flag |= FLAG_REGEX;
	}

	$obj->append({ flag => $flag }, $_) if $_ ne '';
    }

    if (@or) {
	my $flag = $orig_flag | FLAG_OR;
	$obj->append({ flag => $flag }, @or);
    }
}

sub load_file {
    my $obj = shift;
    my $arg = ref $_[0] eq 'HASH' ? shift : {};

    $arg->{type} = 'pattern';
    my $flag = ( $arg->{flag} // 0 ) | FLAG_REGEX | FLAG_COOK | FLAG_OR;

    for my $file (@_) {
	open my $fh, '<:encoding(utf8)', $file or die "$file: $!\n";
	my @p = do {
	    map  { chomp ; s{\s*//.*}{} ; $_ }
	    grep { not m{^\s*(?:#|//|$)} }
	    <$fh>
	};
	close $fh;
	$obj->append({ flag => $flag }, @p);
    }
}

sub patterns {
    my $obj = shift;
    @{ $obj };
}

1;
