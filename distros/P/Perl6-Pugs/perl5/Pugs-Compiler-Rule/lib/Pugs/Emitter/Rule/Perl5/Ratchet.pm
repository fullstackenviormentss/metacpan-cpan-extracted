package Pugs::Emitter::Rule::Perl5::Ratchet;

# p6-rule perl5 emitter for ":ratchet" (non-backtracking)
# see: RuleInline.pl, RuleInline-more.pl for a program prototype

use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Indent = 1;

our $direction = "+";  # XXX make lexical
our $sigspace = 0;
our $capture_count;
our $capture_to_array;

our $count = 1000 + int(rand(1000));
sub id { 'I' . ($count++) }

sub call_subrule {
    my ( $subrule, $tab, @param ) = @_;
    $subrule = "\$grammar->" . $subrule 
        unless $subrule =~ / :: | \. | -> /x;
    $subrule =~ s/\./->/;   # XXX - source filter
    return 
"$tab     $subrule( \$s, { p => \$pos, args => {" .
             join(", ",@param) . 
         "} }, undef )";
}

sub quote_constant {
    my $const;
    if ( $_[0] eq "\\" ) {
        $const = "chr(".ord("\\").")";
    }
    elsif ( $_[0] eq "'" ) {
        $const = "chr(".ord("'").")"
    }
    else {
        $const = "'$_[0]'"
    }
    return $const;
}

sub call_constant {
    return " 1 # null constant\n"
        unless length($_[0]);
    my $const = quote_constant( $_[0] );
    my $len = length( eval $const );
    #print "Const: [$_[0]] $const $len \n";    
    return
"$_[1] ( ( substr( \$s, \$pos, $len ) eq $const ) 
$_[1]     ? ( \$pos $direction= $len or 1 )
$_[1]     : 0
$_[1] )";
}

sub call_perl5 {
    my $const = $_[0];
    #print "CONST: $const - $direction \n";
    return
"$_[1] ( ( substr( \$s, \$pos ) =~ m/^($const)/ )  
$_[1]     ? ( \$pos $direction= length( \$1 ) or 1 )
$_[1]     : 0
$_[1] )";
}

sub emit {
    my ($grammar, $ast, $param) = @_;
    # runtime parameters: $grammar, $string, $state, $arg_list
    # rule parameters: see Runtime::Rule.pm
    local $sigspace = $param->{sigspace};   # XXX - $sigspace should be lexical
    local $capture_count = -1;
    local $capture_to_array = 0;
    #print "rule: ", Dumper( $ast );
    return 
        "do { my \$rule; \$rule = sub {
  my \$grammar = \$_[0];
  my \$s = \$_[1];
  no warnings 'substr', 'uninitialized', 'syntax';
  my \%pad;\n" .
        #"  my \$pos;\n" .
        #"  print \"match arg_list = \$_[1]\n\";\n" .
        #"  print 'match ', Dumper(\\\@_);\n" .
        #"  print \"match arg_list = \@{[\%{\$_[1]} ]}\n\" if defined \$_[1];\n" .
        #"  print \"match pos = \$pos\n\";\n" .
"  my \$m;
  for my \$pos ( defined \$_[3]{p} && ! \$_[3]{continue} 
        ? \$_[3]{p} 
        : ( ( \$_[3]{p} || 0 ) .. length( \$s ) ) ) {
    my \%index; 
    my \@match;
    my \%named;
    my \$bool = 1;
    \$named{KEY} = \$_[3]{KEY} if exists \$_[3]{KEY};
    \$m = Pugs::Runtime::Match->new( { 
      str => \\\$s, from => \\(0+\$pos), to => \\(\$pos), 
      bool => \\\$bool, match => \\\@match, named => \\\%named, capture => undef, 
    } );
    {
      my \$prior = \$::_V6_PRIOR_;
      local \$::_V6_PRIOR_ = \$prior; 
      \$bool = 0 unless
" .
        #"      do { TAILCALL: ;\n" .
        emit_rule( $ast, '    ' ) . ";
    }
    if ( \$bool ) {
      my \$prior = \$::_V6_PRIOR_;
      \$::_V6_PRIOR_ = sub { 
        local \$main::_V6_PRIOR_ = \$prior; 
        \$rule->(\@_);
      };
      last;
    }
  } # /for
  \$::_V6_MATCH_ = \$m;
  return \$m;
} }
";
}

sub emit_rule {
    my $n = $_[0];
    my $tab = $_[1] . '  ';
    die "unknown node: ", Dumper( $n )
        unless ref( $n ) eq 'HASH';
    #print "NODE ", Dumper($n);
    my ($k) = keys %$n;
    my $v = $$n{$k};
    # XXX - use real references
    no strict 'refs';
    #print "NODE ", Dumper($k), ", ", Dumper($v);
    my $code = &$k( $v, $tab );
    return $code;
}

#rule nodes

sub non_capturing_group {
    return emit_rule( $_[0], $_[1] );
}        
sub quant {
    my $term = $_[0]->{'term'};
    my $quantifier = $_[0]->{quant}  || '';
    my $greedy     = $_[0]->{greedy} || '';   # + ?
    die "greediness control not implemented: $greedy"
        if $greedy;
    #print "QUANT: ",Dumper($_[0]);
    # TODO: fix grammar to not emit empty quantifier
    my $tab = ( $quantifier eq '' ) ? $_[1] : $_[1] . "  ";
    my $ws = metasyntax( '?ws', $tab );
    my $ws3 = ( $sigspace && $_[0]->{ws3} ne '' ) ? " &&\n$ws" : '';

    my $rul;
    {
        #print "Term: ", Dumper($term), "\n";
        my $cap = $capture_to_array;
        local $capture_to_array = $cap || ( $quantifier ne '' );
        $rul = emit_rule( $term, $tab );
    }

    $rul = "$ws &&\n$rul" if $sigspace && $_[0]->{ws1} ne '';
    $rul = "$rul &&\n$ws" if $sigspace && $_[0]->{ws2} ne '';
    #print $rul;
    return $rul 
        if $quantifier eq '';
    # *  +  ?
    # TODO: *? +? ??
    # TODO: *+ ++ ?+
    # TODO: quantifier + capture creates Array
    return 
        "$_[1] (\n$rul\n" .
        "$_[1] || ( \$bool = 1 )\n" .
        "$_[1] ) $ws3"
        if $quantifier eq '?';
    return 
        "$_[1] do { while (\n$rul) {}; \$bool = 1 }$ws3"
        if $quantifier eq '*';
    return
        "$_[1] (\n$rul\n" .
        "$_[1] && do { while (\n$rul) {}; \$bool = 1 }\n" .
        "$_[1] ) $ws3"
        if $quantifier eq '+';
    die "quantifier not implemented: $quantifier";
}        
sub alt {
    my @s;
    # print 'Alt: ';
    my $count = $capture_count;
    my $max = -1;
    my $id = id();
    for ( @{$_[0]} ) { 
        $capture_count = $count;
        my $tmp = emit_rule( $_, $_[1].'  ' );
        # print ' ',$capture_count;
        $max = $capture_count 
            if $capture_count > $max;
        push @s, $tmp if $tmp;   
    }
    $capture_count = $max;
    # print " max = $capture_count\n";
    return 
        "$_[1] (
$_[1]     ( \$pad{$id} = \$pos or 1 ) 
$_[1]     && (
" . join( "
$_[1]     ) 
$_[1]   || ( 
$_[1]     ( ( \$bool = 1 ) && ( \$pos = \$pad{$id} ) or 1 ) 
$_[1]     && ", 
          @s 
    ) . "
$_[1]   )
$_[1] )";
}        
sub concat {
    my @s;

=for optimizing
    # optimize for the common case of "words"
    # Note: this optimization has almost no practical effect
    my $is_constant = 0;
    for ( @{$_[0]} ) {
        if ( ! $sigspace && exists $_->{quant} ) {
            my $was_constant = $is_constant;
            $is_constant = 
                   $_->{quant}->{quant} eq ''
                && exists $_->{quant}->{term}->{constant};
            #print "concat: ", Dumper( $_ );
            if ( $is_constant && $was_constant && $direction ne '-' ) {
                $s[-1]->{quant}->{term}->{constant} .=
                    $_->{quant}->{term}->{constant};
                #print "constant: ",$s[-1]->{quant}->{term}->{constant},"\n";
                next;
            }
        }
        push @s, $_;
    }

    for ( @s ) { 
        $_ = emit_rule( $_, $_[1] );
    }
=cut

    for ( @{$_[0]} ) {
        my $tmp = emit_rule( $_, $_[1] );
        push @s, $tmp if $tmp;   
    }
    @s = reverse @s if $direction eq '-';
    return "$_[1] (\n" . join( "\n$_[1] &&\n", @s ) . "\n$_[1] )";
}        
sub code {
    return "$_[1] $_[0]\n";  
}        
sub dot {
    "$_[1] ( substr( \$s, \$pos$direction$direction, 1 ) ne '' )"
}

sub variable {
    my $name = "$_[0]";
    my $value = undef;
    # XXX - eval $name doesn't look up in user lexical pad
    # XXX - what &xxx interpolate to?
    
    if ( $name =~ /^\$/ ) {
        # $^a, $^b
        if ( $name =~ /^ \$ \^ ([^\s]*) /x ) {
            my $index = ord($1)-ord('a');
            #print "Variable #$index\n";
            #return "$_[1] constant( \$_[7][$index] )\n";
            
            my $code = 
            "    ... sub { 
                #print \"Runtime Variable args[\", join(\",\",\@_) ,\"] \$_[7][$index]\\n\";
                return constant( \$_[7][$index] )->(\@_);
            }";
            $code =~ s/^/$_[1]/mg;
            return "$code\n";
        }
        else {
            $value = eval $name;
        }
    }
    
    $value = join('', eval $name) if $name =~ /^\@/;
    if ( $name =~ /^%/ ) {
        my $id = '$' . id();
        my $preprocess_hash = 'Pugs::Runtime::Regex::preprocess_hash';
        my $code = "
          do {
            our $id;
            our ${id}_sizes;
            unless ( $id ) {
                my \$hash = " . 
                ( $name =~ /::/ 
                    ? "\\$name" 
                    : "Pugs::Runtime::Regex::get_variable( '$name' )"
                ) . 
                ";
                my \%sizes = map { length(\$_) => 1 } keys \%\$hash;
                ${id}_sizes = [ sort { \$b <=> \$a } keys \%sizes ];
                " . #print \"sizes: \@${id}_sizes\\n\";
                "$id = \$hash;
            }
            " . #print 'keys: ',Dumper( $id );
            "my \$match = 0;
            my \$key;
            for ( \@". $id ."_sizes ) {
                \$key = ( \$pos <= length( \$s ) 
                            ? substr( \$s, \$pos, \$_ )
                            : '' );
                " . #print \"try ".$name." \$_ = \$key; \$s\\\n\";
                "if ( exists ". $id ."->{\$key} ) {
                    #\$named{KEY} = \$key;
                    #\$::_V6_MATCH_ = \$m; 
                    #print \"m: \", Dumper( \$::_V6_MATCH_->data )
                    #    if ( \$key eq 'until' );
                    " . #print \"* ".$name."\{'\$key\'} at \$pos \\\n\";
                    "\$match = $preprocess_hash( $id, \$key )->( \$s, \$grammar, { p => ( \$pos + \$_ ), args => { KEY => \$key } }, undef );
                    " . #print \"match: \", Dumper( \$match->data );
                    "last if \$match;
                }
            }
            if ( \$match ) {
                \$pos = \$match->to;
                #print \"match: \$key at \$pos = \", Dumper( \$match->data );
                \$bool = 1;
            }; # else { \$bool = 0 }
            \$match;
          }";
        #print $code;
        return $code;
    }
    die "interpolation of $name not implemented"
        unless defined $value;

    return call_constant( $value, $_[1] );
}
sub special_char {
    my $char = substr($_[0],1);
    return  call_perl5( '(?:\n\r?|\r\n?)', $_[1] )
        if $char eq 'n';
    return  call_perl5( '(?!\n\r?|\r\n?).', $_[1] )
        if $char eq 'N';
    for ( qw( r n t e f w d s ) ) {
        return call_perl5(   "\\$_",  $_[1] ) if $char eq $_;
        return call_perl5( "[^\\$_]", $_[1] ) if $char eq uc($_);
    }
    $char = '\\\\' if $char eq '\\';
    return call_constant( $char, $_[1] );
}
sub match_variable {
    my $name = $_[0];
    my $num = substr($name,1);
    #print "var name: ", $num, "\n";
    my $code = 
    "    ... sub { 
        my \$m = Pugs::Runtime::Match->new( \$_[2] );
        return constant( \"\$m->[$num]\" )->(\@_);
    }";
    $code =~ s/^/$_[1]/mg;
    return "$code\n";
}
sub closure {
    my $code = $_[0]; 
    
    if ( ref( $code ) ) {
        if ( defined $Pugs::Compiler::Perl6::VERSION ) {
            #print " perl6 compiler is loaded \n";
            my $perl5 = Pugs::Emitter::Perl6::Perl5::emit( 'grammar', $code, 'self' );
            return 
                "do { 
                    \$::_V6_MATCH_ = \$m; 
                    local \$::_V6_SUCCEED = 1;
                    \$m->data->{capture} = \\( sub $perl5->() );
                    \$bool = \$::_V6_SUCCEED;
                    \$::_V6_MATCH_ = \$m if \$bool; 
                    return \$m if \$bool;
                }" if $perl5 =~ /return/;
            return 
                "do { 
                    \$::_V6_MATCH_ = \$m; 
                    local \$::_V6_SUCCEED = 1;
                    sub $perl5->();
                    \$::_V6_SUCCEED;
                }";
        }        
    }

    #print " perl6 compiler is NOT loaded \n";
            
    # XXX XXX XXX - source-filter - temporary hacks to translate p6 to p5
    # $()<name>
    $code =~ s/ ([^']) \$ \( \) < (.*?) > /$1\$_[0]->[$2]/sgx;
    # $<name>
    $code =~ s/ ([^']) \$ < (.*?) > /$1\$_[0]->{named}->{$2}/sgx;
    # $()
    $code =~ s/ ([^']) \$ \( \) /$1\$_[0]->()/sgx;
    # $/
    $code =~ s/ ([^']) \$ \/ /$1\$_[0]/sgx;
    
    $code =~ s/ use \s+ v6 \s* ; / # use v6\n/sgx;

    #print "Code: $code\n";
    
    return 
        "$_[1] do {\n" .
        "$_[1]   local \$::_V6_SUCCEED = 1;\n" .
        "$_[1]   \$::_V6_MATCH_ = \$m;\n" .
        "$_[1]   sub $code->( \$m );\n" .
        "$_[1]   \$::_V6_SUCCEED;\n" .
        "$_[1] }" 
        unless $code =~ /return/;
        
    return
        "$_[1] do { \n" .
        "$_[1]   local \$::_V6_SUCCEED = 1;\n" .
        "$_[1]   \$::_V6_MATCH_ = \$m;\n" .
        "$_[1]   \$m->data->{capture} = \\( sub $code->( \$m ) ); \n" .
        "$_[1]   \$bool = \$::_V6_SUCCEED;\n" .
        "$_[1]   \$::_V6_MATCH_ = \$m if \$bool; \n" .
        "$_[1]   return \$m if \$bool; \n" .
        "$_[1] }";

}
sub capturing_group {
    my $program = $_[0];

    $capture_count++;
    {
        local $capture_count = -1;
        local $capture_to_array = 0;
        $program = emit_rule( $program, $_[1].'      ' )
            if ref( $program );
    }

    return "$_[1] do{ 
$_[1]     my \$hash = do {
$_[1]       my \$bool = 1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       \$bool = 0 unless
" .             $program . ";
$_[1]       { str => \\\$s, from => \\\$from, match => \\\@match, named => \\\%named, bool => \\\$bool, to => \\(0+\$pos), capture => undef }
$_[1]     };
$_[1]     my \$bool = \${\$hash->{'bool'}};" .
        ( $capture_to_array 
        ? "
$_[1]     if ( \$bool ) {
$_[1]         push \@{ \$match[ $capture_count ] }, Pugs::Runtime::Match->new( \$hash );
$_[1]     }"
        : "
$_[1]     \$match[ $capture_count ] = Pugs::Runtime::Match->new( \$hash );"
        ) . "
$_[1]     \$bool;
$_[1] }";
}        

sub capture_as_result {
    my $program = $_[0];

    $capture_count++;
    {
        local $capture_count = -1;
        local $capture_to_array = 0;
        $program = emit_rule( $program, $_[1].'      ' )
            if ref( $program );
    }
    return "$_[1] do{ 
$_[1]     my \$hash = do {
$_[1]       my \$bool = 1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       \$bool = 0 unless
" .             $program . ";
$_[1]       { str => \\\$s, from => \\\$from, match => \\\@match, named => \\\%named, bool => \\\$bool, to => \\(0+\$pos), capture => undef }
$_[1]     };
$_[1]     my \$bool = \${\$hash->{'bool'}};
$_[1]     \$m->data->{capture} = \\( \"\" . Pugs::Runtime::Match->new( \$hash ) );
$_[1]     \$bool;
$_[1] }";
}        
sub named_capture {
    my $name    = $_[0]{ident};
    $name = $name->{match_variable} if ref($name) eq 'HASH';
    $name =~ s/^[\$\@\%]//;  # TODO - change semantics as needed
    my $program = $_[0]{rule};
    #print "name [$name]\n";
    
    if ( exists $program->{metasyntax} ) {
        #print "aliased subrule\n";
        # $/<name> = $/<subrule>
        
        my $cmd = $program->{metasyntax};
        die "invalid aliased subrule" 
            unless $cmd =~ /^[_[:alnum:]]/;
        
        # <subrule ( param, param ) >
        my ( $subrule, $param_list ) = split( /[\(\)]/, $cmd );
        $param_list = '' unless defined $param_list;
        my @param = split( ',', $param_list );
        return "$_[1] do { 
                my \$prior = \$::_V6_PRIOR_; 
                my \$match = \n" . 
                    call_subrule( $subrule, $_[1]."        ", @param ) . ";
                \$::_V6_PRIOR_ = \$prior; 
                if ( \$match ) {" .
                    ( $capture_to_array 
                    ? " push \@{\$named{'$name'}}, \$match;" 
                    : " \$named{'$name'} = \$match;"
                    ) . "
                    \$pos = \$match->to; 
                    1 
                } 
                else { 0 }
            }";
    }
    elsif ( exists $program->{capturing_group} ) {
        #print "aliased capturing_group\n";
        # $/<name> = $/[0]
        {
            local $capture_count = -1;
            local $capture_to_array = 0;
            $program = emit_rule( $program, $_[1].'      ' )
                if ref( $program );
        }
        return "$_[1] do{ 
                my \$match = Pugs::Runtime::Match->new( do {
                    my \$bool = 1;
                    my \$from = \$pos;
                    my \@match;
                    my \%named;
                    \$bool = 0 unless " .
                    $program . ";
                    { str => \\\$s, from => \\\$from, match => \\\@match, named => \\\%named, bool => \\\$bool, to => \\(0+\$pos), capture => undef }
                } );
                if ( \$match ) {" .
                    ( $capture_to_array 
                    ? " push \@{\$named{'$name'}}, \$match;" 
                    : " \$named{'$name'} = \$match;"
                    ) . "
                    \$pos = \$match->to; 
                    1 
                } 
                else { 0 }
            }";
    }
    else {
        #print "aliased non_capturing_group\n";
        # $/<name> = "$/"
        #print Dumper( $_[0] );
        $program = emit_rule( $program, $_[1].'      ' );
        return "$_[1] do{ 
                my \$from = \$pos;
                my \$bool = $program;
                my \$match = Pugs::Runtime::Match->new( 
                    { str => \\\$s, from => \\\$from, match => [], named => {}, bool => \\1, to => \\(0+\$pos), capture => undef }
                );" .
                ( $capture_to_array 
                ? " push \@{\$named{'$name'}}, \$match;" 
                : " \$named{'$name'} = \$match;"
                ) . "
                \$bool
            }";
    }
}
sub negate {
    my $program = $_[0];
    # print Dumper($_[0]);
    $program = emit_rule( $program, $_[1].'        ' )
        if ref( $program );
    return "$_[1] do{ 
$_[1]     my \$pos1 = \$pos;
$_[1]     do {
$_[1]       my \$pos = \$pos1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       \$bool = " . $program . " ? 0 : 1;
$_[1]       \$bool;
$_[1]     };
$_[1] }";
}
sub before {
    my $program = $_[0]{rule};
    $program = emit_rule( $program, $_[1].'        ' )
        if ref( $program );
    return "$_[1] do{ 
$_[1]     my \$pos1 = \$pos;
$_[1]     do {
$_[1]       my \$pos = \$pos1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       \$bool = 0 unless
" .             $program . ";
$_[1]       \$bool;
$_[1]     };
$_[1] }";
}
sub not_before {
    my $program = $_[0]{rule};
    $program = emit_rule( $program, $_[1].'        ' )
        if ref( $program );
    return "$_[1] do{ 
$_[1]     my \$pos1 = \$pos;
$_[1]     do {
$_[1]       my \$pos = \$pos1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       my \$bool = 1;
$_[1]       \$bool = 0 unless
" .             $program . ";
$_[1]       ! \$bool;
$_[1]     };
$_[1] }";
}
sub after {
    local $direction = "-";
    my $program = $_[0]{rule};
    $program = emit_rule( $program, $_[1].'        ' )
        if ref( $program );
    return "$_[1] do{ 
$_[1]     my \$pos1 = \$pos;
$_[1]     do {
$_[1]       my \$pos = \$pos1 - 1;
$_[1]       my \$from = \$pos;
$_[1]       my \@match;
$_[1]       my \%named;
$_[1]       \$bool = 0 unless
" .             $program . ";
$_[1]       \$bool;
$_[1]     };
$_[1] }";
}
sub not_after {
    warn '<!after ...> not implemented';
    return;
}
sub colon {
    my $str = $_[0];
    return "$_[1] 1 # : no-op\n"
        if $str eq ':';
    return "$_[1] ( \$pos >= length( \$s ) ) \n" 
        if $str eq '$';
    return "$_[1] ( \$pos == 0 ) \n" 
        if $str eq '^';
        
    return "$_[1] ( \$pos >= length( \$s ) || substr( \$s, \$pos ) =~ /^(?:\n\r?|\r\n?)/m ) \n" 
        if $str eq '$$';
    return "$_[1] ( \$pos == 0 || substr( \$s, 0, \$pos ) =~ /(?:\n\r?|\r\n?)\$/m ) \n" 
        if $str eq '^^';

    return metasyntax( '?_wb_left', $_[1] )
        if $str eq '<<';
    return metasyntax( '?_wb_right', $_[1] )
        if $str eq '>>';
        
    die "'$str' not implemented";
}
sub modifier {
    my $str = $_[0];
    die "modifier '$str' not implemented";
}
sub constant {
    call_constant( @_ );
}

use vars qw( %char_class );
BEGIN {
    %char_class = map { $_ => 1 } qw( 
        alpha alnum ascii blank
        cntrl digit graph lower
        print punct space upper
        word  xdigit
    );
}

sub metasyntax {
    # <cmd>
    my $cmd = $_[0];   
    my $prefix = substr( $cmd, 0, 1 );
    if ( $prefix eq '@' ) {
        # XXX - wrap @array items - see end of Pugs::Grammar::Rule
        # TODO - param list
        my $name = substr( $cmd, 1 );
        return 
            "$_[1] do {
                my \$match; 
                for my \$subrule ( $cmd ) { 
                    \$match = \$subrule->match( \$s, \$grammar, { p => ( \$pos ), args => {} }, undef );
                    last if \$match; 
                }
                if ( \$match ) {" .
                    ( $capture_to_array 
                    ? " push \@{\$named{'$name'}}, \$match;" 
                    : " \$named{'$name'} = \$match;"
                    ) . "
                    \$pos = \$match->to; 
                    1 
                } 
                else { 0 }
            }";
    }

    if ( $prefix eq '%' ) {
        # XXX - runtime or compile-time interpolation?
        my $name = substr( $cmd, 1 );
        # print "<$cmd>\n";
        # return variable( $cmd );
        return "$_[1] do{ 
                my \$match = " . variable( $cmd, $_[1] ) . ";
                if ( \$match ) {" .
                    ( $capture_to_array 
                    ? " push \@{\$named{'$name'}}, \$match;" 
                    : " \$named{'$name'} = \$match;"
                    ) . "
                    \$pos = \$match->to; 
                    1 
                } 
                else { 0 }
            }";
    }

    if ( $prefix eq '$' ) {
        if ( $cmd =~ /::/ ) {
            # call method in fully qualified $package::var
            # ...->match( $rule, $str, $grammar, $flags, $state )  
            # TODO - send $pos to subrule
            return 
                "$_[1]         do {\n" .
                "$_[1]           push \@match,\n" . 
                "$_[1]             $cmd->match( \$s, \$grammar, {p => \$pos}, undef );\n" .
                "$_[1]           \$pos = \$match[-1]->to;\n" .
                "$_[1]           !\$match[-1] != 1;\n" .
                "$_[1]         }"
        }
        # call method in lexical $var
        # TODO - send $pos to subrule
        return 
                "$_[1]         do {\n" .
                "$_[1]           my \$r = Pugs::Runtime::Regex::get_variable( '$cmd' );\n" . 
                "$_[1]           push \@match,\n" . 
                "$_[1]             \$r->match( \$s, \$grammar, {p => \$pos}, undef );\n" .
                "$_[1]           \$pos = \$match[-1]->to;\n" .
                "$_[1]           !\$match[-1] != 1;\n" .
                "$_[1]         }"
    }
    if ( $prefix eq q(') ) {   # single quoted literal ' 
        $cmd = substr( $cmd, 1, -1 );
        return call_constant( $cmd, $_[1] );
    }
    if ( $prefix eq q(") ) {   # interpolated literal "
        $cmd = substr( $cmd, 1, -1 );
        warn "<\"...\"> not implemented";
        return;
    }
    if ( $prefix =~ /[-+[]/ ) {   # character class 
        $cmd =~ s/\.\./-/g;
        if ( $prefix eq '-' ) {
           $cmd = '[^' . substr($cmd, 2);
        } 
        elsif ( $prefix eq '+' ) {
           $cmd = substr($cmd, 2);
        }
        $cmd =~ s/\s+|\n//g;
        # XXX <[^a]> means [\^a] instead of [^a] in perl5re
        return call_perl5($cmd, $_[1]);
    }
    if ( $prefix eq '?' ) {   # non_capturing_subrule / code assertion
        $cmd = substr( $cmd, 1 );
        if ( $cmd =~ /^{/ ) {
            warn "code assertion not implemented";
            return;
        }
        if ( exists $char_class{$cmd} ) {
            # XXX - inlined char classes are not inheritable, but this should be ok
            return call_perl5( "[[:$cmd:]]", $_[1] );
        }
        my @param; # TODO
        my $subrule = $cmd;
        return
"$_[1] do { 
$_[1]      my \$prior = \$::_V6_PRIOR_; 
$_[1]      my \$match = \n" . 
               call_subrule( $subrule, $_[1]."        ", @param ) . ";
$_[1]      \$::_V6_PRIOR_ = \$prior; 
$_[1]      my \$bool = (!\$match != 1);
$_[1]      \$pos = \$match->to if \$bool;
$_[1]      \$match;
$_[1] }";
    }
    if ( $prefix =~ /[_[:alnum:]]/ ) {  
        if ( $cmd eq 'cut' ) {
            warn "<$cmd> not implemented";
            return;
        }
        if ( $cmd eq 'commit' ) {
            warn "<$cmd> not implemented";
            return;
        }
        if ( $cmd eq 'null' ) {
            return "$_[1] 1 # null\n"
        }
        # <subrule ( param, param ) >
        my ( $subrule, $param_list ) = split( /[\(\)]/, $cmd );
        $param_list ||= '';

        if ( $subrule eq 'at' ) {
            $param_list ||= 0;   # XXX compile-time only
            return "$_[1] ( \$pos == $param_list )\n"
        }

        return named_capture(
            { 
                ident => $subrule, 
                rule => { metasyntax => $cmd },
            }, 
            $_[1],    
        );
    }
    if ( $prefix eq '.' ) {  
        my ( $method, $param_list ) = split( /[\(\)]/, $cmd );
        $method =~ s/^\.//;
        $param_list ||= '';
        return " ( \$s->$method( $param_list ) ? 1 : 0 ) ";
    }
    die "<$cmd> not implemented";
}

1;
