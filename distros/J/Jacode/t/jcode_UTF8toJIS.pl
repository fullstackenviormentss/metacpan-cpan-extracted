sub BEGIN {
    eval q<
        use FindBin;
        use lib "$FindBin::Bin/..";
    >;
}
require 'lib/jacode.pl';

while (<>) {
    chop;
    &jcode'convert(*_, 'jis', 'utf8');
    print $_, "\n";
}

1;
__END__
