#!/usr/bin/perl -w
#############################################################################
## Name:        script/make_ppm.pl
## Purpose:     builds the Wx and Wx-dev PPMs
## Author:      Mattia Barbon
## Modified by:
## Created:     25/08/2003
## RCS-ID:      $Id: make_ppm.pl 2089 2007-07-21 12:10:50Z mbarbon $
## Copyright:   (c) 2003, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use File::Find;
use Archive::Tar 0.23;
use Module::Info;
use Config;

find( { wanted => \&wanted,
      },
      'blib' );

my @files;

sub wanted {
  return unless -f $_;
  push @files, $File::Find::name;
}

my( @dev, @bin );

foreach ( @files ) {
  if( m[\.(?:lib|a|h)$]i
      ) {
    push @dev, $_;
    next;
  }

  push @bin, $_;
}

my $auth   = 'Mattia Barbon <mbarbon@cpan.org>';
my $wx_ver = Module::Info->new_from_file( 'Wx.pm' )->version;

my @ppms =
  ( { files    => [ @bin ],
      package  => 'Wx',
      version  => $wx_ver,
      abstract => 'perl interface to the wxWigdets GUI library',
      author   => $auth,
    },
    { files    => [ @dev ],
      package  => 'Wx-dev',
      version  => $wx_ver,
      abstract => 'developement files for wxPerl',
      author   => $auth,
    },
  );

foreach my $ppm ( @ppms ) {
  make_ppm( %$ppm );
}

sub make_ppm {
  my %data = @_;
  my $tar = Archive::Tar->new;
  my $pack_ver = join ",", (split (/\./, $data{version}), (0) x 4) [0 .. 3];
  my $author = $data{author}; $author =~ s/</&lt;/g; $author =~ s/>/&gt;/g;
  my $arch = $Config{archname} . ( $] >= 5.008 ? '-5.8' : '' );
  my $base = $data{package} . '-' . $data{version};
  my $tarfile = "$base-ppm.tar.gz";
  my $ppdfile = "$base.ppd";
  my $ppd = <<EOT;
<SOFTPKG NAME="$data{package}" VERSION="$pack_ver">
	<TITLE>$data{package}</TITLE>
	<ABSTRACT>$data{abstract}</ABSTRACT>
	<AUTHOR>$author</AUTHOR>
	<IMPLEMENTATION>
		<OS NAME="$^O" />
                <ARCHITECTURE NAME="$arch" />
                <CODEBASE HREF="$tarfile" />
        </IMPLEMENTATION>
</SOFTPKG>
EOT

  $tar->add_files( @{$data{files}} );
  $tar->write( $tarfile, 9 );

  local *PPD;
  open PPD, "> $ppdfile" or die "open '$ppdfile': $!";
  binmode PPD;
  print PPD $ppd;
  close PPD;
}

exit 0;
