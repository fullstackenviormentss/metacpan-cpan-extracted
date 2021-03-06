package Microsoft::AdCenter::V8::CampaignManagementService::Test::AddSitePlacementsResponse;
# Copyright (C) 2012 Xerxes Tsang
# This program is free software; you can redistribute it and/or modify it
# under the terms of Perl Artistic License.

use strict;
use warnings;

use base qw/Test::Class/;
use Test::More;

use Microsoft::AdCenter::V8::CampaignManagementService;
use Microsoft::AdCenter::V8::CampaignManagementService::AddSitePlacementsResponse;

sub test_can_create_add_site_placements_response_and_set_all_fields : Test(2) {
    my $add_site_placements_response = Microsoft::AdCenter::V8::CampaignManagementService::AddSitePlacementsResponse->new
        ->SitePlacementIds('site placement ids')
    ;

    ok($add_site_placements_response);

    is($add_site_placements_response->SitePlacementIds, 'site placement ids', 'can get site placement ids');
};

1;
