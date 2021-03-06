# chopp.t

use Test::Most;

use Text::Chompp qw/ chopp /;

my @tests = (
    {   name   => 'scalar',
        sub    => sub { chopp "hello\n" },
        result => "hello",
    },
    {   name   => 'list',
        sub    => sub { [ chopp "hello\n", "there\n" ] },
        result => [ "hello", "there" ],
    },
    {   name   => 'map',
        sub    => sub { [ map { chopp } "hello\n", "there\n" ] },
        result => [ "hello", "there" ],
    },
    {   name   => 'map with $_',
        sub    => sub { [ map { chopp $_ } "hello\n", "there\n" ] },
        result => [ "hello", "there" ],
    },

);

foreach my $test (@tests) {

    note $test->{name};

    is_deeply $test->{sub}->(), $test->{result}, "result ok";
}

note "testing input unchanged";

my $input = "hello\n";
ok my $output = chopp($input), "chompp";

is $input,  "hello\n", "input unchanged";
is $output, "hello",   "output chompped";

done_testing();

