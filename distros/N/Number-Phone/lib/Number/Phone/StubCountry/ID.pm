# automatically generated file, don't edit



# Copyright 2011 David Cantrell, derived from data from libphonenumber
# http://code.google.com/p/libphonenumber/
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
package Number::Phone::StubCountry::ID;
use base qw(Number::Phone::StubCountry);

use strict;
use warnings;
use utf8;
our $VERSION = 1.20180410221546;

my $formatters = [
                {
                  'pattern' => '(\\d{2})(\\d{5,8})',
                  'national_rule' => '(0$1)',
                  'leading_digits' => '
            2[124]|
            [36]1
          ',
                  'format' => '$1 $2'
                },
                {
                  'leading_digits' => '
            2[035-9]|
            [36][02-9]|
            [4579]
          ',
                  'national_rule' => '(0$1)',
                  'format' => '$1 $2',
                  'pattern' => '(\\d{3})(\\d{5,8})'
                },
                {
                  'format' => '$1-$2-$3',
                  'national_rule' => '0$1',
                  'leading_digits' => '8[1-35-9]',
                  'pattern' => '(8\\d{2})(\\d{3,4})(\\d{3})'
                },
                {
                  'pattern' => '(8\\d{2})(\\d{4})(\\d{4,5})',
                  'national_rule' => '0$1',
                  'leading_digits' => '8[1-35-9]',
                  'format' => '$1-$2-$3'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '1500',
                  'national_rule' => '$1',
                  'pattern' => '(1)(500)(\\d{3})'
                },
                {
                  'leading_digits' => '177',
                  'national_rule' => '0$1',
                  'format' => '$1 $2',
                  'pattern' => '(177)(\\d{6,8})'
                },
                {
                  'pattern' => '(800)(\\d{5,7})',
                  'leading_digits' => '800',
                  'national_rule' => '0$1',
                  'format' => '$1 $2'
                },
                {
                  'format' => '$1 $2 $3',
                  'leading_digits' => '804',
                  'national_rule' => '0$1',
                  'pattern' => '(804)(\\d{3})(\\d{4})'
                },
                {
                  'pattern' => '(80\\d)(\\d)(\\d{3})(\\d{3})',
                  'leading_digits' => '80[79]',
                  'national_rule' => '0$1',
                  'format' => '$1 $2 $3 $4'
                }
              ];

my $validators = {
                'voip' => '',
                'toll_free' => '
          177\\d{6,8}|
          800\\d{5,7}
        ',
                'fixed_line' => '
          2(?:
            1(?:
              14\\d{3}|
              500\\d{3}|
              \\d{7,8}
            )|
            2\\d{6,8}|
            4\\d{7,8}
          )|
          (?:
            2(?:
              [35][1-4]|
              6[0-8]|
              7[1-6]|
              8\\d|
              9[1-8]
            )|
            3(?:
              1|
              [25][1-8]|
              3[1-68]|
              4[1-3]|
              6[1-3568]|
              7[0-469]|
              8\\d
            )|
            4(?:
              0[1-589]|
              1[01347-9]|
              2[0-36-8]|
              3[0-24-68]|
              43|
              5[1-378]|
              6[1-5]|
              7[134]|
              8[1245]
            )|
            5(?:
              1[1-35-9]|
              2[25-8]|
              3[124-9]|
              4[1-3589]|
              5[1-46]|
              6[1-8]
            )|
            6(?:
              19?|
              [25]\\d|
              3[1-69]|
              4[1-6]
            )|
            7(?:
              02|
              [125][1-9]|
              [36]\\d|
              4[1-8]|
              7[0-36-9]
            )|
            9(?:
              0[12]|
              1[013-8]|
              2[0-479]|
              5[125-8]|
              6[23679]|
              7[159]|
              8[01346]
            )
          )\\d{5,8}
        ',
                'personal_number' => '',
                'pager' => '',
                'mobile' => '
          (?:
            2(?:
              1(?:
                3[145]|
                4[01]|
                5[1-469]|
                60|
                8[0359]
              )|
              2(?:
                88|
                9[1256]
              )|
              3[1-4]9|
              4(?:
                36|
                91
              )|
              5(?:
                1[349]|
                [2-4]9
              )|
              6[0-7]9|
              7(?:
                [1-36]9|
                4[39]
              )|
              8[1-5]9|
              9[1-48]9
            )|
            3(?:
              19[1-3]|
              2[12]9|
              3[13]9|
              4(?:
                1[69]|
                39
              )|
              5[14]9|
              6(?:
                1[69]|
                2[89]
              )|
              709
            )|
            4[13]19|
            5(?:
              1(?:
                19|
                8[39]
              )|
              4[129]9|
              6[12]9
            )|
            6(?:
              19[12]|
              2(?:
                [23]9|
                77
              )
            )|
            7(?:
              1[13]9|
              2[15]9|
              419|
              5(?:
                1[89]|
                29
              )|
              6[15]9|
              7[178]9
            )
          )\\d{5,6}|
          8[1-35-9]\\d{7,10}
        ',
                'specialrate' => '(804\\d{7})|(809\\d{7})|(
          1500\\d{3}|
          8071\\d{6}
        )',
                'geographic' => '
          2(?:
            1(?:
              14\\d{3}|
              500\\d{3}|
              \\d{7,8}
            )|
            2\\d{6,8}|
            4\\d{7,8}
          )|
          (?:
            2(?:
              [35][1-4]|
              6[0-8]|
              7[1-6]|
              8\\d|
              9[1-8]
            )|
            3(?:
              1|
              [25][1-8]|
              3[1-68]|
              4[1-3]|
              6[1-3568]|
              7[0-469]|
              8\\d
            )|
            4(?:
              0[1-589]|
              1[01347-9]|
              2[0-36-8]|
              3[0-24-68]|
              43|
              5[1-378]|
              6[1-5]|
              7[134]|
              8[1245]
            )|
            5(?:
              1[1-35-9]|
              2[25-8]|
              3[124-9]|
              4[1-3589]|
              5[1-46]|
              6[1-8]
            )|
            6(?:
              19?|
              [25]\\d|
              3[1-69]|
              4[1-6]
            )|
            7(?:
              02|
              [125][1-9]|
              [36]\\d|
              4[1-8]|
              7[0-36-9]
            )|
            9(?:
              0[12]|
              1[013-8]|
              2[0-479]|
              5[125-8]|
              6[23679]|
              7[159]|
              8[01346]
            )
          )\\d{5,8}
        '
              };
my %areanames = (
  6221 => "Greater\ Jakarta",
  6222 => "Bandung\/Cimahi",
  62231 => "Cirebon",
  62232 => "Kuningan",
  62233 => "Majalengka",
  62234 => "Indramayu",
  6224 => "Semarang\/Demak",
  62251 => "Bogor",
  62252 => "Rangkasbitung",
  62253 => "Pandeglang",
  62254 => "Serang\/Merak",
  62257 => "Serang",
  62260 => "Subang",
  62261 => "Sumedang",
  62262 => "Garut",
  62263 => "Cianjur",
  62264 => "Purwakarta\/Cikampek",
  62265 => "Tasikmalaya\/Banjar\/Ciamis",
  62266 => "Sukabumi",
  62267 => "Karawang",
  62271 => "Surakarta\/Sukoharjo\/Karanganyar\/Sragen",
  62272 => "Klaten",
  62273 => "Wonogiri",
  62274 => "Yogyakarta",
  62275 => "Purworejo",
  62276 => "Boyolali",
  62280 => "West\ Cilacap",
  62281 => "Banyumas\/Purbalingga",
  62282 => "East\ Cilacap",
  62283 => "Tegal\/Brebes",
  62284 => "Pemalang",
  62285 => "Pekalongan\/Batang\/Comal",
  62286 => "Banjarnegara\/Wonosobo",
  62287 => "Kebumen\/Karanganyar",
  62289 => "Bumiayu",
  62291 => "Demak\/Jepara\/Kudus",
  62292 => "Purwodadi",
  62293 => "Magelang\/Mungkid\/Temanggung",
  62294 => "Kendal",
  62295 => "Pati\/Rembang",
  62296 => "Blora",
  62297 => "Karimun\ Jawa",
  62298 => "Salatiga\/Ambarawa",
  62299 => "Nusakambangan",
  6231 => "Surabaya",
  62321 => "Mojokerto\/Jombang",
  62322 => "Lamongan",
  62323 => "Sampang",
  62324 => "Pamekasan",
  62325 => "Sangkapura",
  62326 => "Masalembu\ Islands",
  62327 => "Kangean\/Masalembu",
  62328 => "Sumenep",
  62331 => "Jember",
  62332 => "Bondowoso",
  62333 => "Banyuwangi",
  62334 => "Lumajang",
  62335 => "Probolinggo",
  62336 => "Jember",
  62338 => "Situbondo",
  62341 => "Malang\/Batu",
  62342 => "Blitar",
  62343 => "Pasuruan",
  62351 => "Madiun\/Magetan\/Ngawi",
  62352 => "Ponorogo",
  62353 => "Bojonegoro",
  62354 => "Kediri",
  62355 => "Tulungagung\/Trenggalek",
  62356 => "Rembang\/Tuban",
  62357 => "Pacitan",
  62358 => "Nganjuk",
  62361 => "Denpasar",
  62362 => "Singaraja",
  62363 => "Amlapura",
  62364 => "Mataram",
  62365 => "Negara\/Gilimanuk",
  62366 => "Klungkung\/Bangli",
  62368 => "Baturiti",
  62370 => "Mataram\/Praya",
  62371 => "Sumbawa",
  62372 => "Alas\/Taliwang",
  62373 => "Dompu",
  62374 => "Bima",
  62376 => "Selong",
  62380 => "Kupang",
  62381 => "Ende",
  62382 => "Maumere",
  62383 => "Larantuka",
  62384 => "Bajawa",
  62385 => "Labuhanbajo\/Ruteng",
  62386 => "Kalabahi",
  62387 => "Waingapu\/Waikabubak",
  62388 => "Kefamenanu\/Soe",
  62389 => "Atambua",
  62401 => "Kendari",
  62402 => "Baubau",
  62403 => "Raha",
  62404 => "Wanci",
  62405 => "Kolaka",
  62408 => "Unaaha",
  62410 => "Pangkep",
  62411 => "Makassar\/Maros\/Sungguminasa",
  62413 => "Bulukumba\/Bantaeng",
  62414 => "Kepulauan\ Selayar",
  62417 => "Malino",
  62418 => "Takalar",
  62419 => "Jeneponto",
  62420 => "Enrekang",
  62421 => "Parepare\/Pinrang",
  62422 => "Majene",
  62423 => "Makale\/Rantepao",
  62426 => "Mamuju",
  62427 => "Barru",
  62428 => "Polewali",
  62430 => "Amurang",
  62431 => "Manado\/Tomohon\/Tondano",
  62432 => "Tahuna",
  62434 => "Kotamobagu",
  62435 => "Gorontalo",
  62438 => "Bitung",
  62443 => "Marisa",
  62445 => "Buol",
  62450 => "Parigi",
  62451 => "Palu",
  62452 => "Poso",
  62453 => "Tolitoli",
  62454 => "Tinombo",
  62455 => "Kotaraya\/Moutong",
  62457 => "Donggala",
  62458 => "Tentena",
  62461 => "Luwuk",
  62462 => "Banggai",
  62463 => "Bunta",
  62464 => "Ampana",
  62465 => "Kolonedale",
  62471 => "Palopo",
  62472 => "Pitumpanua",
  62473 => "Masamba",
  62474 => "Malili",
  62475 => "Soroako",
  62481 => "Watampone",
  62482 => "Sinjai",
  62484 => "Watansoppeng",
  62485 => "Sengkang",
  62511 => "Banjarmasin",
  62512 => "Pelaihari",
  62513 => "Muara\ Teweh",
  62517 => "Kandangan\/Barabai\/Rantau\/Negara",
  62518 => "Kotabaru\/Batulicin",
  62522 => "Ampah",
  62525 => "Buntok",
  62526 => "Tamiang\ Layang\/Tanjung",
  62527 => "Amuntai",
  62528 => "Purukcahu",
  62531 => "Sampit",
  62532 => "Pangkalan\ Bun",
  62534 => "Ketapang",
  62536 => "Palangkaraya\/Kasongan",
  62537 => "Kuala\ Kurun",
  62538 => "Kuala\ Pembuang",
  62539 => "Kuala\ Kuayan",
  62541 => "Samarinda\/Tenggarong",
  62542 => "Balikpapan",
  62543 => "Tanah\ Grogot",
  62545 => "Melak",
  62548 => "Bontang",
  62549 => "Sangatta",
  62551 => "Tarakan",
  62552 => "Tanjungselor",
  62553 => "Malinau",
  62554 => "Tanjung\ Redeb",
  62556 => "Nunukan",
  62561 => "Pontianak\/Mempawah",
  62562 => "Singkawang\/Sambas\/Bengkayang",
  62563 => "Ngabang",
  62564 => "Sanggau",
  62565 => "Sintang",
  62567 => "Putussibau",
  62568 => "Nanga\ Pinoh",
  6261 => "Medan",
  62620 => "Pangkalan\ Brandan",
  62621 => "Tebing\ Tinggi\/Sei\ Rampah",
  62622 => "Pematangsiantar\/Pematang\ Raya\/Limapuluh",
  62623 => "Kisaran\/Tanjung\ Balai",
  62624 => "Panipahan\/Labuhanbatu",
  62625 => "Parapat\/Ajibata\/Simanindo",
  62626 => "Pangururan",
  62627 => "Subulussalam\/Sidikalang\/Salak",
  62628 => "Kabanjahe\/Sibolangit",
  62629 => "Kutacane",
  62630 => "Teluk\ Dalam",
  62631 => "Sibolga\/Pandan",
  62632 => "Balige",
  62633 => "Tarutung\/Dolok\ Sanggul",
  62634 => "Padang\ Sidempuan\/Sipirok",
  62635 => "Gunung\ Tua",
  62636 => "Panyabungan\/Sibuhuan",
  62639 => "Gunung\ Sitoli",
  62641 => "Langsa",
  62642 => "Blang\ Kejeren",
  62643 => "Takengon",
  62644 => "Bireuen",
  62645 => "Lhokseumawe",
  62646 => "Idi",
  62650 => "Sinabang",
  62651 => "Banda\ Aceh\/Jantho\/Lamno",
  62652 => "Sabang",
  62653 => "Sigli",
  62654 => "Calang",
  62655 => "Meulaboh",
  62656 => "Tapaktuan",
  62657 => "Bakongan",
  62658 => "Singkil",
  62659 => "Blangpidie",
  62702 => "Tebing\ Tinggi",
  62711 => "Palembang",
  62712 => "Kayu\ Agung\/Tanjung\ Raja",
  62713 => "Prabumulih\/Talang\ Ubi",
  62714 => "Sekayu",
  62715 => "Belinyu",
  62716 => "Muntok",
  62717 => "Pangkal\ Pinang\/Sungailiat",
  62718 => "Koba\/Toboali",
  62719 => "Manggar\/Tanjung\ Pandan",
  62721 => "Bandar\ Lampung",
  62722 => "Tanggamus",
  62723 => "Blambangan\ Umpu",
  62724 => "Kotabumi",
  62725 => "Metro",
  62726 => "Menggala",
  62727 => "Kalianda",
  62728 => "Liwa",
  62729 => "Pringsewu",
  62730 => "Pagar\ Alam\/Kota\ Agung",
  62731 => "Lahat",
  62732 => "Curup",
  62733 => "Lubuklinggau\/Muara\ Beliti",
  62734 => "Muara\ Enim",
  62735 => "Baturaja\/Martapura\/Muaradua",
  62736 => "Bengkulu\ City",
  62737 => "Arga\ Makmur\/Mukomuko",
  62738 => "Muara\ Aman",
  62739 => "Bintuhan\/Manna",
  62740 => "Mendahara\/Muara\ Sabak",
  62741 => "Jambi\ City",
  62742 => "Kualatungkal\/Tebing\ Tinggi",
  62743 => "Muara\ Bulian",
  62744 => "Muara\ Tebo",
  62745 => "Sarolangun",
  62746 => "Bangko",
  62747 => "Muarabungo",
  62748 => "Sungai\ Penuh\/Kerinci",
  62751 => "Padang\/Pariaman",
  62752 => "Bukittinggi\/Padang\ Panjang\/Payakumbuh\/Batusangkar",
  62753 => "Lubuk\ Sikaping",
  62754 => "Sijunjung",
  62755 => "Solok",
  62756 => "Painan",
  62757 => "Balai\ Selasa",
  62760 => "Teluk\ Kuantan",
  62761 => "Pekanbaru",
  62762 => "Bangkinang\/Pasir\ Pengaraian",
  62763 => "Selatpanjang",
  62764 => "Siak\ Sri\ Indrapura",
  62765 => "Dumai\/Duri\/Bagan\ Batu\/Ujung\ Tanjung",
  62766 => "Bengkalis",
  62767 => "Bagansiapiapi",
  62768 => "Tembilahan",
  62769 => "Rengat\/Air\ Molek",
  62771 => "Tanjung\ Pinang",
  62772 => "Tarempa",
  62773 => "Ranai",
  62776 => "Dabosingkep",
  62777 => "Karimun",
  62778 => "Batam",
  62779 => "Tanjungbatu",
  62901 => "Timika",
  62902 => "Agats",
  62910 => "Bandanaira",
  62911 => "Ambon",
  62913 => "Namlea",
  62914 => "Masohi",
  62915 => "Bula",
  62916 => "Tual",
  62917 => "Dobo",
  62918 => "Saumlaku",
  62921 => "Soasiu",
  62922 => "Jailolo",
  62923 => "Morotai",
  62924 => "Tobelo",
  62927 => "Labuha",
  62929 => "Sanana",
  62931 => "Saparua",
  62951 => "Sorong",
  62952 => "Teminabuan",
  62955 => "Bintuni",
  62956 => "Fakfak",
  62957 => "Kaimana",
  62966 => "Sarmi",
  62967 => "Jayapura",
  62969 => "Wamena",
  62971 => "Merauke",
  62975 => "Tanahmerah",
  62980 => "Ransiki",
  62981 => "Biak",
  62983 => "Serui",
  62984 => "Nabire",
  62985 => "Nabire",
  62986 => "Manokwari",
);
    sub new {
      my $class = shift;
      my $number = shift;
      $number =~ s/(^\+62|\D)//g;
      my $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self if ($self->is_valid());
      $number =~ s/^(?:0)//;
      $self = bless({ number => $number, formatters => $formatters, validators => $validators, areanames => \%areanames}, $class);
      return $self->is_valid() ? $self : undef;
    }
1;