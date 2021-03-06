package HTTP::MobileAgent::Flash::SoftBankFlashMap;
# -------------------------------------------------------------------------
# This file is autogenerated by make_map_flash_lite.pl
# in HTTP::MobileAgent::Flash distribution.
#
# make_map_flash_lite.pl --carrier=softbank --output=pm
# -------------------------------------------------------------------------

use strict;
use warnings;

require Exporter;
use base qw(Exporter);
our @EXPORT_OK = qw($FLASH_MAP);
our $FLASH_MAP;

BEGIN {
    if ($ENV{SOFTBANK_FLASH_MAP}) {
        eval q{
            require YAML::Syck;
            $FLASH_MAP = YAML::Syck::LoadFile($ENV{SOFTBANK_FLASH_MAP});
        };
        if ($@) {
            eval q{
                require YAML;
                $FLASH_MAP = YAML::LoadFile($ENV{SOFTBANK_FLASH_MAP});
            };
        }
        warn "using normal hash map: $@" if $@;
    }
}

$FLASH_MAP ||= {
    '001N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '001P' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '001SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '002P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '002SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '004SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '008SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '103P' => {
        version        => '3.1',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '105SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '108SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '810P' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '810SH' => {
        version        => '2.0',
        width          => '480',
        height         => '640',
        max_file_size  => '150',
    },
    '810T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '811SH' => {
        version        => '2.0',
        width          => '480',
        height         => '640',
        max_file_size  => '150',
    },
    '811T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '812SH' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '812T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '813SH' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '813T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '814SH' => {
        version        => '2.0',
        width          => '480',
        height         => '640',
        max_file_size  => '150',
    },
    '814T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '815SH' => {
        version        => '2.0',
        width          => '480',
        height         => '640',
        max_file_size  => '150',
    },
    '815T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '816SH' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '820N' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '820P' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '820SC' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '820SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '820T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '821P' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '821SC' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '821SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '821T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '822P' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '822SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '822T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '823P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '823SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '823T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '824P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '824SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '824T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '825SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '830CA' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '830N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '830P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '830SH' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '830T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '831N' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '831P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '831SH' => {
        version        => '3.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '831T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '832P' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '832SH' => {
        version        => '3.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '832T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '840N' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '840P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '840SC' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '840SH' => {
        version        => '3.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '840Z' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '841N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '841P' => {
        version        => '2.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '841SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '842P' => {
        version        => '3.0',
        width          => '240',
        height         => '427',
        max_file_size  => '150',
    },
    '842SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '843SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '910SH' => {
        version        => '2.0',
        width          => '480',
        height         => '640',
        max_file_size  => '150',
    },
    '910T' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '911SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '911T' => {
        version        => '2.0',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '912SH' => {
        version        => '2.0',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '912T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '913SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '920P' => {
        version        => '2.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '920SC' => {
        version        => '2.0',
        width          => '240',
        height         => '320',
        max_file_size  => '150',
    },
    '920SH' => {
        version        => '2.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '920T' => {
        version        => '2.0',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '921P' => {
        version        => '2.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '921SH' => {
        version        => '2.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '921T' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    '922SH' => {
        version        => '2.0',
        width          => '854',
        height         => '480',
        max_file_size  => '150',
    },
    '923SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '930CA' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '930N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '930P' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '930SC' => {
        version        => '3.1',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '930SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '931N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '931P' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '931SC' => {
        version        => '3.1',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '931SH' => {
        version        => '3.0',
        width          => '480',
        height         => '1024',
        max_file_size  => '150',
    },
    '932SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '933SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '934SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '935SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '936SH' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '940N' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '940P' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '940SC' => {
        version        => '3.1',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '940SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '941P' => {
        version        => '3.0',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '941SC' => {
        version        => '3.1',
        width          => '480',
        height         => '800',
        max_file_size  => '150',
    },
    '941SH' => {
        version        => '3.1',
        width          => '480',
        height         => '1024',
        max_file_size  => '150',
    },
    '942P' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '942SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '943SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '944SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    '945SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    'DM001SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'DM002SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'DM003SH' => {
        version        => '2.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'DM004SH' => {
        version        => '3.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'DM005SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    'DM006SH' => {
        version        => '3.0',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'DM007SH' => {
        version        => '3.1',
        width          => '480',
        height         => '854',
        max_file_size  => '150',
    },
    'DM008SH' => {
        version        => '3.1',
        width          => '240',
        height         => '400',
        max_file_size  => '150',
    },
    'V703SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V703SHf' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V705SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V802SE' => {
        version        => '1.1',
        width          => '176',
        height         => '220',
        max_file_size  => '100',
    },
    'V802SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V804SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V902SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V903SH' => {
        version        => '1.1',
        width          => '240',
        height         => '320',
        max_file_size  => '100',
    },
    'V904SH' => {
        version        => '1.1',
        width          => '480',
        height         => '640',
        max_file_size  => '100',
    },
    'V905SH' => {
        version        => '1.1',
        width          => '240',
        height         => '400',
        max_file_size  => '100',
    },
};

1;