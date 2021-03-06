package Rapi::Blog::DB::ResultSet::Hit;

use strict;
use warnings;

use Moo;
extends 'DBIx::Class::ResultSet';

use RapidApp::Util ':all';
use Rapi::Blog::Util;

use YAML::XS;

sub create_from_request {
  my ($self, $create, $request) = @_;
  $create ||= {};

  $create = { %$create,
    client_ip          => $request->address,
    uri                => $request->uri,
    method             => $request->method,
    user_agent         => $request->header('User-Agent'),
    referer            => $request->header('Referer'),
    
    # Not sure if this is worth it or not:
    #serialized_request => do { try{
    #  my $x = bless { %$request }, ref($request);
    #  delete $x->{_context};
    #  YAML::XS::Dump($x)
    #}}
    
  } if($request);
  
  $request->{ts} ||= Rapi::Blog::Util->now_ts;
  
  $self->create( $create )
}



1;
