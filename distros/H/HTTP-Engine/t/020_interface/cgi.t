use strict;
use warnings;
use HTTP::Engine;
use HTTP::Engine::Interface::CGI;
use IO::Scalar;
use Test::Base;

tie *STDOUT, 'IO::Scalar', \my $out;
tie *STDIN, 'IO::Scalar', \my $in;

plan tests => 1*blocks;

filters {
    env => [qw/yaml/],
    response => [qw/chop crlf/],
};

run {
    my $block = shift;
    local %ENV = %{$block->env};

    HTTP::Engine->new(
        interface => {
            module => 'CGI',
            args => { },
            request_handler => sub {
                my $req = shift;
                HTTP::Engine::Response->new(
                    status  => 200,
                    headers => HTTP::Headers::Fast->new( 'X-Req-Base' => $req->base, ),
                    body    => 'OK!',
                );
            },
        },
    )->run;

    is $out, $block->response(), 'response';
};

sub crlf {
    my $in = shift;
    $in =~ s/\n/\r\n/g;
    $in;
}

__END__

===
--- env
REMOTE_ADDR:    127.0.0.1
SERVER_PORT:    80
QUERY_STRING:   ''
REQUEST_METHOD: 'GET'
HTTP_HOST: localhost
--- response
Content-Length: 3
Content-Type: text/html
Status: 200
X-Req-Base: http://localhost/

OK!
