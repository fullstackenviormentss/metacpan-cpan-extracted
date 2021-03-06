use FindBin;
use Test::More;
use Google::Spreadsheet::Agent;
use YAML::Any qw/LoadFile/;
use strict;
use warnings;

my $conf_file = $FindBin::Bin.'/../config/agent.conf.yml';
if (-e $conf_file) {
  plan( tests => 1 );
}
else {
  plan( 
    skip_all => 'You must create a valid test Google Spreadsheet and a valid '
                .$conf_file
                .' configuration file pointing to it to run the tests. See README.txt file for more information on how to run the tests.'
      );
}

my $new_email_address = 'fooby@bar.baz';
my $config = YAML::Any::LoadFile($conf_file);
$config->{send_to} = $new_email_address;

my $google_db = Google::Spreadsheet::Agent::DB->new(
                   config => $config
                 );

is ($google_db->config->{send_to}, $new_email_address, 'Config should have send_to: '.$new_email_address);
