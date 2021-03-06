package Microsoft::AdCenter::V6::ReportingService::AdTypeReportFilter;
# Copyright (C) 2012 Xerxes Tsang
# This program is free software; you can redistribute it and/or modify it
# under the terms of Perl Artistic License.

use strict;
use warnings;

=head1 NAME

Microsoft::AdCenter::V6::ReportingService::AdTypeReportFilter - Represents "AdTypeReportFilter" in Microsoft AdCenter Reporting Service.

=head1 SYNOPSIS

See L<http://msdn.microsoft.com/en-us/library/ee730327.aspx> for documentation of the various data objects.

=head1 ENUMERATION VALUES

    Image
    Mobile
    RichMedia
    Text
    ThirdPartyCreative

=cut

sub Image {
    return 'Image';
}

sub Mobile {
    return 'Mobile';
}

sub RichMedia {
    return 'RichMedia';
}

sub Text {
    return 'Text';
}

sub ThirdPartyCreative {
    return 'ThirdPartyCreative';
}

1;
