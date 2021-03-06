#!/usr/bin/perl

use strict;
use warnings;

package WWW::Shopify::Liquid::Token;
use base 'WWW::Shopify::Liquid::Element';
sub new { return bless { line => $_[1], core => $_[2] }, $_[0]; };
sub stringify { return $_[0]->{core}; }
sub tokens { return $_[0]; }

package WWW::Shopify::Liquid::Token::Operator;
use base 'WWW::Shopify::Liquid::Token';

package WWW::Shopify::Liquid::Token::Operand;
use base 'WWW::Shopify::Liquid::Token';

package WWW::Shopify::Liquid::Token::String;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub process { my ($self, $hash) = @_; return $self->{core}; }

package WWW::Shopify::Liquid::Token::Number;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub process { my ($self, $hash) = @_; return $self->{core}; }

package WWW::Shopify::Liquid::Token::NULL;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub process { return undef; }

package WWW::Shopify::Liquid::Token::Bool;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub process { my ($self, $hash) = @_; return $self->{core}; }

package WWW::Shopify::Liquid::Token::FunctionCall;
use base 'WWW::Shopify::Liquid::Token::Operand';

use Scalar::Util qw(looks_like_number reftype blessed);

sub new {
	my $package = shift;
	return bless {
		line => shift,
		method => shift,
		self => shift,
		arguments => [@_]
	}, $package;
}

sub process {
	my ($self, $hash, $action, $pipeline) = @_;
	if ($action eq "render") {
		die new WWW::Shopify::Liquid::Exception::Renderer::Forbidden($self->{line}) unless $pipeline->make_method_calls;
		
		my @arguments = map { $self->is_processed($_) ? $_ : $_->render($pipeline, $hash) } @{$self->{arguments}};
		my $inner_self = $self->is_processed($self->{self}) ? $self->{self} : $self->{self}->render($pipeline, $hash);
		my $method = $self->is_processed($self->{method}) ? $self->{method} : $self->{method}->render($pipeline, $hash);
		die new WWW::Shopify::Liquid::Exception::Renderer($self->{line}, "Can't find method $method on $inner_self.") unless $inner_self && blessed($inner_self) && !ref($method);
		return $inner_self->$method(@arguments);
	}
	return $self;
	
}

package WWW::Shopify::Liquid::Token::Variable;
use base 'WWW::Shopify::Liquid::Token::Operand';

use Scalar::Util qw(looks_like_number reftype blessed);

sub new { my $package = shift; return bless { line => shift, core => [@_] }, $package; };
sub process {
	my ($self, $hash, $action, $pipeline) = @_;
	my $place = $hash;
	
	my @inner = @{$self->{core}};
	my $unprocessed = 0;
	foreach my $part_idx (0..$#inner) {
		my $part = $inner[$part_idx];
		if (ref($part) eq 'WWW::Shopify::Liquid::Token::Variable::Processing') {
			$place = $part->$action($pipeline, $hash, $place);
		}
		else {
			my $key = $self->is_processed($part) ? $part : $part->$action($pipeline, $hash);
			
			return $self unless defined $key && $key ne '';
			$self->{core}->[$part_idx] = $key if $self->is_processed($key) && $action eq "optimize";
			if (defined $place) {
				if (blessed($place) && $place->isa('WWW::Shopify::Liquid::Resolver')) {
					$place = $place->resolver->($place, $hash, $key);
				} elsif (reftype($place) && reftype($place) eq "HASH" && exists $place->{$key}) {
					$place = $place->{$key};
				} elsif (reftype($place) && reftype($place) eq "ARRAY" && looks_like_number($key) && defined $place->[$key]) {
					$place = $place->[$key];
				} elsif ($pipeline->make_method_calls && blessed($place) && $place->can($key)) {
					$place = $place->$key;
				} else {
					$unprocessed = 1;
					$place = undef;
				}
			}
			
		}
	}
	return $self if $unprocessed;
	return $place->resolver->($place, $hash) if (blessed($place) && $place->isa('WWW::Shopify::Liquid::Resolver'));
	return $place;
}
sub stringify { return join(".", map { $_->stringify } @{$_[0]->{core}}); }

sub set {
	my ($self, $pipeline, $hash, $value) = @_;
	my @vars = map { $self->is_processed($_) ? $_ : $_->render($pipeline, $hash) } @{$self->{core}};
	my ($reference) = $pipeline->variable_reference($hash, \@vars);
	$$reference = $value;
	return 1;
}


sub get {
	my ($self, $pipeline, $hash) = @_;
	my @vars = map { $self->is_processed($_) ? $_ : $_->render($pipeline, $hash) } @{$self->{core}};
	my ($reference) = $pipeline->variable_reference($hash, \@vars, 1);
	return $reference ? $$reference : undef;
}

package WWW::Shopify::Liquid::Token::Variable::Processing;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub process {
	my ($self, $hash, $argument, $action, $pipeline) = @_;
	return $self if !$self->is_processed($argument);
	my $result = $self->{core}->operate($hash, $argument);
	return $self if !$self->is_processed($result);
	return $result;
}

package WWW::Shopify::Liquid::Token::Variable::Named;
use base 'WWW::Shopify::Liquid::Token::Operand';

sub new { my $package = shift; return bless { line => shift, name => shift, core => shift }, $package; };
sub process {
	my ($self, $hash, $action, $pipeline) = @_;
	return { $self->{name} => $self->{core}->$action($pipeline, $hash) };
}


package WWW::Shopify::Liquid::Token::Grouping;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub new { my $package = shift; return bless { line => shift, members => [@_] }, $package; };
sub members { return @{$_[0]->{members}}; }

# Parentheses
package WWW::Shopify::Liquid::Token::Grouping::Parenthetical;
use base 'WWW::Shopify::Liquid::Token::Grouping';

# Like a grouping, but not really.
# Square brackets
package WWW::Shopify::Liquid::Token::Array;
use base 'WWW::Shopify::Liquid::Token::Operand';

sub new { 
	my ($package, $line, @members) = @_;
	# Check to see whether or not the incoming member array is separated by commas.
	# Should never begin with a comma, should never end with a comma, should always be 
	# 101010101 in terms of data and separators. If this is not the case, then we
	# Should throw a lexing exception.
	die new WWW::Shopify::Liquid::Exception::Lexer::InvalidSeparator($line) unless
		int(grep { ($_ % 2) == 0 && $members[$_]->isa('WWW::Shopify::Liquid::Token::Separator') } (0..$#members)) == 0 &&
		int(grep { ($_ % 2) == 1 && (!$members[$_]->isa('WWW::Shopify::Liquid::Token::Separator') || $members[$_]->{core} ne ",") } (0..$#members)) == 0;
		
	my $self = bless { 
		line => $line,
		members => [grep { !$_->isa('WWW::Shopify::Liquid::Token::Separator') } @members]
	}, $package; 
	return $self;
};

sub members { return @{$_[0]->{members}}; }
sub process { 
	my ($self, $hash, $action, $pipeline) = @_; 
	my @members = $self->members;
	$members[$_] = $members[$_]->$action($pipeline, $hash) for (grep { !$self->is_processed($members[$_]) } (0..$#members));
	if ($action eq "optimize") {
		$self->{members}->[$_] = $_ for (grep { $self->is_processed($members[$_]) } 0..$#members);
	}
	return [@members];
}

# Curly brackets
package WWW::Shopify::Liquid::Token::Hash;
use base 'WWW::Shopify::Liquid::Token::Operand';

sub members { return @{$_[0]->{members}}; }
sub new { 
	my ($package, $line, @members) = @_;
	
	@members = map { $_->isa('WWW::Shopify::Liquid::Token::Variable::Named') ? (
		WWW::Shopify::Liquid::Token::String->new($_->{line}, $_->{name}),
		WWW::Shopify::Liquid::Token::Separator->new($_->{line}, ':'),
		$_->{core}
	) : $_ } @members;
	
	die new WWW::Shopify::Liquid::Exception::Lexer::InvalidSeparator($line) unless
		int(grep { ($_ % 2) == 0 && $members[$_]->isa('WWW::Shopify::Liquid::Token::Separator') } (0..$#members)) == 0 &&
		int(grep { 
			($_ % 4) == 1 && (!$members[$_]->isa('WWW::Shopify::Liquid::Token::Separator') || $members[$_]->{core} ne ":") ||
			($_ % 4) == 3 && (!$members[$_]->isa('WWW::Shopify::Liquid::Token::Separator') || $members[$_]->{core} ne ",") 
		} (0..$#members)) == 0 && 
		int(grep { !$_->isa('WWW::Shopify::Liquid::Token::Separator') } @members) % 2 == 0;
		
	return bless { 
		line => $line,
		members => [grep { !$_->isa('WWW::Shopify::Liquid::Token::Separator') } @members]
	}, $package; 
};

sub process { 
	my ($self, $hash, $action, $pipeline) = @_; 
	my @members = $self->members;
	$members[$_] = $members[$_]->$action($pipeline, $hash) for (grep { !$self->is_processed($members[$_]) } (0..$#members));
	if ($action eq "optimize") {
		$self->{members}->[$_] = $_ for (grep { $self->is_processed($members[$_]) } 0..$#members);
	}
	return { @members };
}


package WWW::Shopify::Liquid::Token::Text;
use base 'WWW::Shopify::Liquid::Token::Operand';
sub new { 
	my $self = { line => $_[1], core => $_[2] };
	my $package = $_[0];
	$package = 'WWW::Shopify::Liquid::Token::Text::Whitespace' if !defined $_[2] || $_[2] =~ m/^\s*$/;
	return bless $self, $package;
};
sub process { my ($self, $hash) = @_; return $self->{core}; }

package WWW::Shopify::Liquid::Token::Text::Whitespace;
use base 'WWW::Shopify::Liquid::Token::Text';

package WWW::Shopify::Liquid::Token::Tag;
use base 'WWW::Shopify::Liquid::Token';
sub new { return bless { line => $_[1], tag => $_[2], arguments => $_[3], strip_left => $_[4], strip_right => $_[5] }, $_[0] };
sub tag { return $_[0]->{tag}; }
sub stringify { return $_[0]->tag; }

package WWW::Shopify::Liquid::Token::Output;
use base 'WWW::Shopify::Liquid::Token';
sub new { return bless { line => $_[1], core => $_[2], strip_left => $_[3], strip_right => $_[4] }, $_[0]; };

package WWW::Shopify::Liquid::Token::Separator;
use base 'WWW::Shopify::Liquid::Token';


package WWW::Shopify::Liquid::Lexer;
use base 'WWW::Shopify::Liquid::Pipeline';
use Scalar::Util qw(looks_like_number blessed);

sub new { return bless { operators => {}, lexing_halters => {}, transparent_filters => {}, unparse_spaces => 0, parse_escaped_characters => 1 }, $_[0]; }
sub operators { return $_[0]->{operators}; }
sub unparse_spaces { $_[0]->{unparse_spaces} = $_[1] if defined $_[1]; return $_[0]->{unparse_spaces}; } 
sub parse_escaped_characters { $_[0]->{parse_escaped_characters} = $_[1] if defined $_[1]; return $_[0]->{parse_escaped_characters}; } 
sub register_operator {	$_[0]->{operators}->{$_} = $_[1] for ($_[1]->symbol); } 
sub register_tag {
	my ($self, $package) = @_;
	$self->{lexing_halters}->{$package->name} = $package if $package->is_enclosing && $package->inner_halt_lexing;
}
sub register_filter {
	my ($self, $package) = @_;
	$self->{transparent_filters}->{$package->name} = $package if ($package->transparent);
}
sub transparent_filters { return $_[0]->{transparent_filters}; }

sub parse_token {
	my ($self, $line, $token) = @_;
		
	# Strip token of whitespace.
	return undef unless defined $token;
	$token =~ s/^\s*(.*?)\s*$/$1/;
	return WWW::Shopify::Liquid::Token::Operator->new($line, $token) if $self->operators->{$token};
	return WWW::Shopify::Liquid::Token::String->new($line, do {
		my $string = $1;
		if ($self->parse_escaped_characters) {
			$string =~ s/\\r/\r/g;
			$string =~ s/\\n/\n/g;
			$string =~ s/\\t/\t/g;
		}
		$string;
	}) if $token =~ m/^'(.*)'$/s || $token =~ m/^"(.*)"$/s;
	return WWW::Shopify::Liquid::Token::Number->new($line, $1) if looks_like_number($token);
	return WWW::Shopify::Liquid::Token::NULL->new() if $token eq '' || $token eq 'null';
	return WWW::Shopify::Liquid::Token::Separator->new($line, $token) if ($token eq ":" || $token eq "," || $token eq ".");
	return WWW::Shopify::Liquid::Token::Array->new($line) if ($token eq "[]");
	return WWW::Shopify::Liquid::Token::Hash->new($line) if ($token eq "{}");
	# We're a variable. Let's see what's going on. Split along non quoted . and [ ] fields.
	my ($squot, $dquot, $start, @parts) = (0,0,0);
	#  customer['test']['b'] 
	my $open_square_bracket = 0;
	my $open_curly_bracket = 0;
	while ($token =~ m/(\.|\[|\]|\{|\}|(?<!\\)\"|(?<!\\)\'|\b$)/g) {
		my $sym = $&;
		my $begin = $-[0];
		my $end = $+[0];
		if (!$squot && !$dquot) {
			$open_square_bracket-- if ($sym && $sym eq "]");
			$open_curly_bracket-- if ($sym && $sym eq "}");
			if (($sym eq "." || $sym eq "]" || $sym eq "[" || $sym eq "{" || $sym eq "}" || !$sym) && $open_square_bracket == 0 && $open_curly_bracket == 0) {
				my $contents = substr($token, $start, $begin - $start);
				
				if (defined $contents && $contents !~ m/^\s*$/) {
					my @variables = ();
					if (!$sym || $sym eq "." || $sym eq "[") {
						@variables = $self->transparent_filters->{$contents} ? WWW::Shopify::Liquid::Token::Variable::Processing->new($line, $self->transparent_filters->{$contents}) : WWW::Shopify::Liquid::Token::String->new($line, $contents);
					}
					elsif ($sym eq "]") {
						@variables = $self->parse_expression($line, $contents);
						return WWW::Shopify::Liquid::Token::Array->new($line, @variables) if (int(@parts) == 0);
					}
					elsif ($sym eq "}") {
						@variables = $self->parse_expression($line, $contents);
						return WWW::Shopify::Liquid::Token::Hash->new($line, @variables) if (int(@parts) == 0);
					}
					if (int(@variables) > 0) {
						if (int(@variables) == 1) {
							push(@parts, @variables);
						}
						else {
							push(@parts, WWW::Shopify::Liquid::Token::Grouping->new($line, @variables)) ;
						}
					}
				}
			}
			$start = $end if $sym ne '"' && $sym ne "'" && !$open_curly_bracket && !$open_square_bracket;
			$open_square_bracket++ if ($sym && $sym eq "[");
			$open_curly_bracket++ if ($sym && $sym eq "{");
			
		}
		$squot = !$squot if $token eq "'";
		$dquot = !$dquot if $token eq '"';
	}
	return WWW::Shopify::Liquid::Token::Variable->new($line, @parts);
}

use utf8;
# Returns a single token repsending the whole a expression.
sub parse_expression {
	my ($self, $line, $exp) = @_;
	return () if !defined $exp || $exp eq '';
	my @tokens = ();
	my ($start_paren, $start_space, $level, $squot, $dquot, $start_sq, $sq_level, $start_hsh, $hsh_level) = (undef, 0, 0, 0, 0, undef, 0, undef, 0);
	# We regex along parentheses, quotation marks (both kinds), whitespace, and non-word-operators.
	# We sort along length, so that we make sure to get all the largest operators first, so that way if a larger operator is made from a smaller one (=, ==)
	# There's no confusion, we always try to match the largest first.
	my $non_word_operators = join("|", map { quotemeta($_) } grep { $_ =~ m/^\W+$/; } sort { length($b) <=> length($a) } keys(%{$self->operators}));
	while ($exp =~ m/(?:\(|\)|\]|\[|\}|\{|(?<!\\)["”“]|(?<!\\)['‘’]|(\s+|$)|($non_word_operators|,|:))/sg) {
		my ($rs, $re, $rc, $whitespace, $nword_op) = ($-[0], $+[0], $&, $1, $2);
		# Specifically to allow variables to have a - in them, and be treated as a long literal, instead of a minus sign.
		# This is terrible behaviour, but mimics Shopify's lexer.
		# Only if of course the entire first half of this ISN'T a number, though. 'cause that'd be insane.
		next if $nword_op && $nword_op eq "-" && $rs > 0 && substr($exp, $rs-1, 1) ne " " && substr($exp, 0, $rs) !~ m/\b\d+$/;
		if (!$squot && !$dquot) {
			$start_paren = $re if $rc eq "(" && $level++ == 0;
			$start_sq = $re if $rc eq "[" && $sq_level++ == 0;
			$start_hsh = $re if $rc eq "{" && $hsh_level++ == 0;
			# Deal with parentheses; always the highest level of operation, except when inside a square bracket.
			if ($rc eq ")" && --$level == 0 && $sq_level == 0 && $hsh_level == 0) {
				$start_space = $re;
				push(@tokens, WWW::Shopify::Liquid::Token::Grouping->new($line, $self->parse_expression($line, substr($exp, $start_paren, $rs - $start_paren))));
			}
			--$sq_level if $rc eq "]";
			--$hsh_level if $rc eq "}";
			if (($level == 0 || ($rc eq "(" && $level == 1)) && $sq_level == 0 && $hsh_level == 0) {
				# If we're only spaces, that means we're a new a token.
				if ($rc eq "(" || defined $whitespace || $nword_op) {
					if (defined $start_space) {
						my $contents = substr($exp, $start_space, $rs - $start_space);
						push(@tokens, $self->parse_token([$line->[0], $line->[1] + $start_space, $line->[2] + $start_space, $line->[4]], $contents)) if $contents !~ m/^\s*$/;
					}
					push(@tokens, $self->parse_token([$line->[0], $line->[1] + $start_space, $line->[2] + $start_space, $line->[4]], $nword_op)) if $nword_op;
					$start_space = $re;
				}
			}
		}
		$squot = !$squot if ($rc eq "'" && !$dquot);
		$dquot = !$dquot if ($rc eq '"' && !$squot);
	}
	die WWW::Shopify::Liquid::Exception::Lexer::UnbalancedBrace->new($line) unless $level == 0;
	# Go through and combine any -1 from OP NUM to NUM.
	my @ids = grep { 
		$tokens[$_]->isa('WWW::Shopify::Liquid::Token::Number') &&
		$tokens[$_-1]->isa('WWW::Shopify::Liquid::Token::Operator') && $tokens[$_-1]->{core} eq "-" &&
		($_ == 1 || $tokens[$_-2]->isa('WWW::Shopify::Liquid::Token::Separator') || $tokens[$_-2]->isa('WWW::Shopify::Liquid::Token::Operator'))
	} 1..$#tokens;
	for (@ids) { $tokens[$_]->{core} *= -1; $tokens[$_-1] = undef; } 
	@tokens = grep { defined $_ } @tokens;
	# Go through and combine colon separated arguments into named arguments.
	@ids = grep {
		($_ == 2 || !$tokens[$_-3]->isa('WWW::Shopify::Liquid::Token::Operator') || $tokens[$_-3]->{core} ne "|") &&
		$tokens[$_-2]->isa('WWW::Shopify::Liquid::Token::Variable') && int(@{$tokens[$_-2]->{core}}) == 1 && $tokens[$_-2]->{core}->[0]->isa('WWW::Shopify::Liquid::Token::String') &&
		$tokens[$_-1]->isa('WWW::Shopify::Liquid::Token::Separator') && $tokens[$_-1]->{core} eq ":" &&
		$tokens[$_]->isa('WWW::Shopify::Liquid::Token::Operand')
	} (2..$#tokens);
	for (@ids) { $tokens[$_] = WWW::Shopify::Liquid::Token::Variable::Named->new($line, $tokens[$_-2]->{core}->[0]->{core}, $tokens[$_]); $tokens[$_-2] = undef; $tokens[$_-1] = undef; }
	@tokens = grep { defined $_ } @tokens;
	return @tokens;
}

sub parse_text {
	my ($self, $text) = @_;
	return () unless defined $text;
	my @tokens = ();
	
	my $line = 1;
	my $line_position = 0;
	
	my $lexing_halter;
	my $open_control_tag;
	my $open_output_tag;
	my $open_single_quote;
	my $open_double_quote;
	my $strip_left;
	
	my $end_offset = 0;
	my $start_position = [1, 0, 0];
	
	# This is a substitution instead of a simple match, because very long perl native UTF8 strings, are variable length
	# meaning any substr, or index operations need to walk the string in order to complete. This is like an o(n^2) consequence
	# so it's fine at smaller lengths, but at larger lengths, it's infeasible to call substr on far offsets with any significant
	# frequency. So we eat the string as we process it. Possibly slightly slower than simple matching on byte-strings, but way
	# faster on UTF-8, and at this point in my life, I just want consistency rather than best-possible-performance (this would because
	# written in D -betterC if I was interested in best possible performance at this point.)
	my $accumulator = '';
	# Step 1. We only care about new lines (to count what line we're on), {% and {{.
	my $count = 0;
	use Time::HiRes qw(time);
	my $start = time;
	while ($text =~ s/^(.*?)(?:(\{\{\-?)|({%\-?))//s) {
		$end_offset += $+[0];
		# These variables are entirely boolean flags.
		my ($start_output_tag, $start_control_tag) = ($2, $3);
		$accumulator .= $1;
		if ($accumulator ne '') {
			# Count the number of lines in the accumulator, to ensure we have the approrpiate line position.
			$line += ($accumulator =~ tr/\r?\n//);
			$line_position = rindex($accumulator, "\n") + $start_position->[2] + 1;
		}
		$open_control_tag = [$line, $end_offset - length($start_control_tag) - $line_position, $end_offset - length($start_control_tag), $self->file_context] if $start_control_tag;
		$open_output_tag =  [$line, $end_offset - length($start_output_tag) -  $line_position, $end_offset - length($start_output_tag), $self->file_context] if $start_output_tag;
		$strip_left = index($start_control_tag || $start_output_tag, "-") != -1;
		
		$accumulator =~ s/^\s*// if int(@tokens) > 0 && $tokens[-1]->{strip_right};
		$accumulator =~ s/\s*$// if $strip_left;
		if ($accumulator ne '') {
			# Count the number of lines in the accumulator.
			push(@tokens, WWW::Shopify::Liquid::Token::Text->new($start_position, $accumulator));
			$accumulator = '';
		}
		last if $text eq '';
		$start_position = [$line, $end_offset - $line_position, $end_offset, $self->file_context];
		
		# Step 2. If we have an open tag, we parse out tokens from argument context inside that tag.
		while ($text =~ s/(.*?)(?:(\")|(\')|(\-?%})|(\-?\}\})|(\r?\n))//s) {
			my ($double_quote, $single_quote, $end_control_tag, $end_output_tag, $newline) = ($2, $3, $4, $5, $6);
			$end_offset += $+[0];
			
			if (!$open_single_quote && !$open_double_quote && ($end_output_tag || $end_control_tag)) {
				my $strip_right = index($end_control_tag || $end_output_tag, "-") != -1;
				$accumulator .= $1;
				if ($end_output_tag) {
					die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedControlTag($open_control_tag) if $open_control_tag;
					push(@tokens, WWW::Shopify::Liquid::Token::Output->new($open_output_tag, [$self->parse_expression($start_position, $accumulator)], $strip_left, $strip_right));
					$open_output_tag = undef;
				} else {
					die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedOutputTag($open_output_tag) if $open_output_tag;
					die new WWW::Shopify::Liquid::Exception::Lexer::Tag($start_position, $accumulator) if $accumulator !~ m/^\s*(\w+)\s*(.*?)\s*$/s;
					push(@tokens, WWW::Shopify::Liquid::Token::Tag->new($open_control_tag, $1, [$self->parse_expression($start_position, $2)], $strip_left, $strip_right));
					$lexing_halter = $tokens[-1] if $self->{lexing_halters}->{$1};
					$open_control_tag = undef;
				}
				$accumulator = '';
				$start_position = [$line, $end_offset - $line_position, $end_offset, $self->file_context];
				last;
			} else {
				if ($newline) {					
					++$line;
					$line_position = $end_offset;
				}
				$open_single_quote = !$open_single_quote if $single_quote && !$open_double_quote;
				$open_double_quote = !$open_double_quote if $double_quote && !$open_single_quote;
				$accumulator .= $&;
			}
		}
		# For lexing halters, consume everything up to the next end tag explicitly.
		if ($lexing_halter) {
			my $core = $lexing_halter->{tag};
			while ($text =~ s/(.*?)(?:({%\-?\s*end$core\s*\-?%})|(\r?\n))//s) {
				if ($3) {
					++$line;
					$line_position = $end_offset;
					$accumulator .= $1 . $3;
				} else {
					$accumulator .= $1;
					push(@tokens, WWW::Shopify::Liquid::Token::Text->new($start_position, $accumulator)) if $accumulator ne '';
					push(@tokens, WWW::Shopify::Liquid::Token::Tag->new($start_position, "end$core", []));
					$accumulator = '';
					$lexing_halter = undef;
					last;
				}
			}
		}
	}
	die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedSingleQuote($open_single_quote) if $open_single_quote;
	die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedDoubleQuote($open_double_quote) if $open_double_quote;
	die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedLexingHalt($lexing_halter) if $lexing_halter;
	die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedControlTag($open_control_tag) if $open_control_tag;
	die new WWW::Shopify::Liquid::Exception::Lexer::UnbalancedOutputTag($open_output_tag) if $open_output_tag;
	$accumulator .= $text;
	$accumulator =~ s/^\s*// if int(@tokens) > 0 && $tokens[-1]->{strip_right};
	push(@tokens, WWW::Shopify::Liquid::Token::Text->new($start_position, $accumulator)) if $accumulator ne '';
	return @tokens;
}

sub unparse_token {
	my ($self, $token) = @_;
	return "null" if !defined $token;
	return '' if $token eq '';
	return "'" . do { $token =~ s/'/\\'/g; $token } . "'" if !blessed($token) && !looks_like_number($token);
	return $token unless blessed($token);
	return "null" if $token->isa('WWW::Shopify::Liquid::Token::NULL');
	return '{}' if ($token->isa('WWW::Shopify::Liquid::Token::Hash'));
	return '[]' if ($token->isa('WWW::Shopify::Liquid::Token::Array'));
	sub translate_variable {
		my ($self, $token) = @_;
		my $variable = join(".", map { 
			!$self->is_processed($_) ? (
				$_->isa('WWW::Shopify::Liquid::Token::Variable') ? ('[' . translate_variable($self, $_) . ']') : 
					($_->isa('WWW::Shopify::Liquid::Token::Variable::Processing') ? $_->{core}->name : $_->{core})
			) : $_
		} @{$token->{core}});
		$variable =~ s/\.\[/\[/g;
		return $variable;
	}
	return $token->{name} . ":" . $self->unparse_token($token->{core}) if ($token->isa('WWW::Shopify::Liquid::Token::Variable::Named'));
	return translate_variable($self, $token) if $token->isa('WWW::Shopify::Liquid::Token::Variable');
	return "(" . join("", map { $self->unparse_token($_); } @{$token->{members}}) . ")" if $token->isa('WWW::Shopify::Liquid::Token::Grouping');
	return "'" . $token->{core} . "'" if $token->isa('WWW::Shopify::Liquid::Token::String');
	return $token->{core};
}

sub unparse_expression {
	my ($self, @tokens) = @_;
	my $a = join("", map { ($_ eq ":" || $_ eq ",") ? $_ : " " . $_; } grep { defined $_ } map { $self->unparse_token($_) } @tokens);
	$a =~ s/^ //;
	return $a;
}

sub unparse_text_segment {
	my ($self, $token) = @_;
	my $space = $self->unparse_spaces ? " " : "";
	return $token if $self->is_processed($token);
	if ($token->isa('WWW::Shopify::Liquid::Token::Tag')) {
		return "{%" . $space . $token->{tag} . $space . "%}" if !$token->{arguments} || int(@{$token->{arguments}}) == 0;
		return "{%" . $space . $token->{tag} . " " . $self->unparse_expression(@{$token->{arguments}}) . $space  . "%}";
	}
	return "{{" . $space . $self->unparse_expression(@{$token->{core}}) . $space . "}}" if $token->isa('WWW::Shopify::Liquid::Token::Output');
	return $token->{core};
}

sub unparse_text {
	my ($self, @tokens) = @_;
	return join('', grep { defined $_ } map { $self->unparse_text_segment($_) } @tokens);
}

1;
