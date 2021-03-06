#!perl

use strict;
use warnings;
use Test::More ;

use Linux::DVB::DVBT ;
use Linux::DVB::DVBT::Freq ;

my @args = (

	{'iso3166'=>'GB',	'results'=>[
		177500000,
		184500000,
		191500000,
		198500000,
		205500000,
		212500000,
		219500000,
		226500000,
		473833000,
		474000000,
		481833000,
		482000000,
		489833000,
		490000000,
		497833000,
		498000000,
		505833000,
		506000000,
		513833000,
		514000000,
		521833000,
		522000000,
		529833000,
		530000000,
		537833000,
		538000000,
		545833000,
		546000000,
		553833000,
		554000000,
		561833000,
		562000000,
		569833000,
		570000000,
		577833000,
		578000000,
		585833000,
		586000000,
		593833000,
		594000000,
		601833000,
		602000000,
		609833000,
		610000000,
		617833000,
		618000000,
		625833000,
		626000000,
		633833000,
		634000000,
		641833000,
		642000000,
		649833000,
		650000000,
		657833000,
		658000000,
		665833000,
		666000000,
		673833000,
		674000000,
		681833000,
		682000000,
		689833000,
		690000000,
		697833000,
		698000000,
		705833000,
		706000000,
		713833000,
		714000000,
		721833000,
		722000000,
		729833000,
		730000000,
		737833000,
		738000000,
		745833000,
		746000000,
		753833000,
		754000000,
		761833000,
		762000000,
		769833000,
		770000000,
		777833000,
		778000000,
		785833000,
		786000000,
		793833000,
		794000000,
		801833000,
		802000000,
		809833000,
		810000000,
		817833000,
		818000000,
		825833000,
		826000000,
		833833000,
		834000000,
		841833000,
		842000000,
		849833000,
		850000000,
		857833000,
		858000000,
		]},

) ;


	my $checks_per_test = 1 ;
	plan tests => scalar(@args) * $checks_per_test ;
	

	my @freqs ;
	my @freqs2 ;
	my $test_num=1 ;
	foreach my $args_href (@args)
	{
		@freqs = Linux::DVB::DVBT::Freq::freq_list($args_href->{'iso3166'}) ;
		@freqs2 = Linux::DVB::DVBT::Freq::chan_freq_list($args_href->{'iso3166'}) ;
		is_deeply(\@freqs, $args_href->{'results'}) ;
		
#Linux::DVB::DVBT::prt_data("Freqs for $args_href->{'iso3166'} = ", \@freqs) ;	

		print "Frequencies for $args_href->{'iso3166'}\n" ;
#		foreach my $href (@freqs2)
#		{
#			printf "%2d : $href->{'freq'}\n", $href->{'chan'} ;
#		}	
		foreach my $href (@freqs2)
		{
			print "\t$href->{'freq'},\n" ;
		}	
	}
	exit 0 ;

	
	
__END__

