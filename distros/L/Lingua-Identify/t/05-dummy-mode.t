#!/usr/bin/perl
use utf8;
use Test::More tests => 10;
BEGIN { use_ok('Lingua::Identify', qw/:language_manipulation :language_identification/) };

my $text = '
As armas e os barões assinalados 
Que, da Ocidental praia Lusitana, 
Por mares nunca de antes navegados 
Passaram ainda além da Taprobana 
E em perigos e guerras esforçados 
Mais do que prometia a força humana, 
E entre gente remota edificaram 
Novo Reino, que tanto sublimaram; 

E também as memórias gloriosas 
Daqueles Reis que foram dilatando 
A Fé, o Império, e as terras viciosas 
De África e de Ásia andaram devastando, 
E aqueles que por obras valerosas 
Se vão da lei da Morte libertando: 
Cantando espalharei por toda parte, 
Se a tanto me ajudar o engenho e arte. 

Cessem do sábio Grego e do Troiano 
As navegações grandes que fizeram; 
Cale-se de Alexandro e de Trajano 
A fama das vitórias que tiveram; 
Que eu canto o peito ilustre Lusitano, 
A quem Neptuno e Marte obedeceram. 
Cesse tudo o que a Musa antiga canta, 
Que outro valor mais alto se alevanta. 

E vós, Tágides minhas, pois criado 
Tendes em mi um novo engenho ardente 
Se sempre, em verso humilde, celebrado 
Foi de mi vosso rio alegremente, 
Dai-me agora um som alto e sublimado, 
Um estilo grandíloco e corrente, 
Por que de vossas águas Febo ordene 
Que não tenham enveja às de Hipocrene. 

Dai-me húa fúria grande e sonorosa, 
E não de agreste avena ou frauta ruda, 
Mas de tuba canora e belicosa, 
Que o peito acende e a cor ao gesto muda; 
Dai-me igual canto aos feitos da famosa 
Gente vossa, que a Marte tanto ajuda; 
Que se espalhe e se cante no Universo, 
Se tão sublime preço cabe em verso. 

E vós, ó bem nascida segurança 
Da Lusitana antiga liberdade, 
E não menos certíssima esperança 
De aumento da pequena Cristandade; 
Vós, ó novo temor da Maura lança, 
Maravilha fatal da nossa idade, 
Dada ao mundo por Deus (que todo o mande, 
Pera do mundo a Deus dar parte grande); 

Vós, tenro e novo ramo florecente, 
De húa árvore, de Cristo mais amada 
Que nenhúa nascida no Ocidente, 
Cesárea ou Cristianíssima chamada, 
(Vede-o no vosso escudo, que presente
Vos amostra a vitória já passada, 
Na qual vos deu por armas e deixou
As que Ele pera Si na Cruz tomou); 

Vós, poderoso Rei, cujo alto Império 
O Sol, logo em nascendo, vê primeiro;
Vê-o também no meio do Hemisfério, 
E, quando dece, o deixa derradeiro;
Vós, que esperamos jugo e vitupério 
Do torpe lsmaelita cavaleiro, 
Do Turco Oriental e do Gentio 
Que inda bebe o licor do santo Rio: 

Inclinai por um pouco a majestade, 
Que nesse tenro gesto vos contemplo,
Que já se mostra qual na inteira idade,
Quando subindo ireis ao eterno Templo;
Os olhos da real benignidade 
Ponde no chão: vereis um novo exemplo
De amor dos pátrios feitos valerosos, 
Em versos devulgado numerosos. 

Vereis amor da pátria, não movido 
De prêmio vil, mas alto e quase eterno;
Que não é prêmio vil ser conhecido 
Por um pregão do ninho meu paterno. 
Ouvi: vereis o nome engrandecido 
Daqueles de quem sois senhor superno, 
E julgareis qual é mais excelente, 
Se ser do mundo Rei, se de tal gente. 

Ouvi: que não vereis com vãs façanhas,
Fantásticas, fingidas, mentirosas,
Louvar os vossos, como nas estranhas Musas,
de engrandecer-se desejosas: 
As verdadeiras vossas são tamanhas, 
Que excedem as sonhadas, fabulosas, 
Que excedem Rodamonte e o vão Rugeiro,
E Orlando, inda que fora verdadeiro. 

Por estes vos darei um Nuno fero, 
Que fez ao Rei e ao Reino tal serviço, 
Um Egas e um Dom Fuas, que de Homero
A cítara para eles só cobiço; 
Pois polos Doze Pares dar-vos quero 
Os Doze de Inglaterra e o seu Magriço;
Dou-vos também aquele ilustre Gama,
Que para si de Eneias toma a fama. 

Pois, se a troco de Carlos, Rei de França,
Ou de César, quereis igual memória,
Vede o primeiro Afonso, cuja lança
Escura faz qualquer estranha glória; 
E aquele que a seu Reino a segurança
Deixou, co a grande e próspera vitória;
Outro Joanne, invicto cavaleiro; 
O quarto e quinto Afonsos e o terceiro. 

Nem deixarão meus versos esquecidos
Aqueles que, nos Reinos lá da Aurora, 
Se fizeram por armas tão subidos, 
Vossa bandeira sempre vencedora: 
Um Pacheeo fortíssimo e os temidos
Almeidas, por quem sempre o Tejo chora,
Albuquerque terribil, Castro forte, 
E outros em quem poder não teve a morte. 

E, enquanto eu estes canto, e a vós não posso,
Sublime Rei, que não me atrevo a tanto,
Tomai as rédeas vós do Reino vosso: 
Dareis matéria a nunca ouvido canto.
Comecem a sentir o peso grosso 
(Que polo mundo todo faça espanto) 
De exércitos e feitos singulares 
De África as terras e do Oriente os mares.
';

my $t1 = langof( { 'mode' => 'dummy' }, $text);

is_deeply( $t1 ,
           {
           'method' => { %Lingua::Identify::default_methods },
           'config' => {
                         'mode' => 'dummy',
                       },
           'max-size' => 1000000,
           'active-languages' => [ sort (get_all_languages()) ],
           'text' => $text,
           'mode' => 'dummy',
           });

$t1 = langof( { method => { smallwords => 1, prefixes2 => 2 }, 'mode' => 'dummy' }, $text);

is_deeply( $t1 ,
           {
           'method' => {
                         'smallwords' => '1',
                         'prefixes2'  => '2',
                       },
           'config' => {
                         'mode' => 'dummy',
                         'method' => {
                                       'smallwords' => '1',
                                       'prefixes2'  => '2',
                                     },
                       },
           'max-size' => 1000000,
           'active-languages' => [ sort (get_all_languages()) ],
           'text' => $text,
           'mode' => 'dummy',
           });

$t1 = langof( { method => [ qw/smallwords prefixes2/ ], 'mode' => 'dummy' }, $text);

is_deeply( $t1 ,
           {
           'method' => {
                         'smallwords' => '1',
                         'prefixes2'  => '1',
                       },
           'config' => {
                         'mode' => 'dummy',
                         'method' => [
                                       'smallwords' ,
                                       'prefixes2'  ,
                                     ],
                       },
           'max-size' => 1000000,
           'active-languages' => [ sort (get_all_languages()) ],
           'text' => $text,
           'mode' => 'dummy',
           });

$t1 = langof( { method => 'smallwords', 'mode' => 'dummy' }, $text);

is_deeply( $t1 ,
           {
           'method' => {
                         'smallwords' => '1',
                       },
           'config' => {
                         'mode' => 'dummy',
                         'method' => 'smallwords',
                       },
           'max-size' => 1000000,
           'active-languages' => [ sort (get_all_languages()) ],
           'text' => $text,
           'mode' => 'dummy',
           });





is_deeply( [ sort (set_active_languages( qw/pt es fr/ )) ] , [ sort qw/pt es fr/ ] );

is_deeply( [ sort (get_active_languages(              )) ] , [ sort qw/pt es fr/ ] );




my $t2 = langof( { 'method' => 'smallwords', 'mode' => 'dummy' }, $text);

is_deeply( $t2 ,
           {
           'method' => {
                          'smallwords' => '1',
                        },
           'config'  => {
                          'mode'       => 'dummy',
                          'method'     => 'smallwords',
                        },
           'max-size'          => 1000000,
           'active-languages' => [
				   'es', 'fr', 'pt',
                                 ],
           'text' => $text,
           'mode' => 'dummy',
           });


my $t3 = langof( { 'max-size' => 100, 'method' => 'smallwords', 'mode' => 'dummy' }, $text);

is_deeply( $t3 ,
           {
           'method' => {
                          'smallwords' => '1',
                        },
           'config'  => {
                          'mode'       => 'dummy',
                          'method'     => 'smallwords',
                          'max-size'   => 100,
                        },
           'max-size'         => 100,
           'active-languages' => [
				   'es', 'fr', 'pt',
                                 ],
           'text' => substr($text,0,100),
           'mode' => 'dummy',
           });

$t3 = langof( { 'max-size' => 0, 'method' => 'smallwords', 'mode' => 'dummy' }, $text);

is_deeply( $t3 ,
           {
           'method' => {
                          'smallwords' => '1',
                        },
           'config'  => {
                          'mode'       => 'dummy',
                          'method'     => 'smallwords',
                          'max-size'   => 0,
                        },
           'max-size'         => 0,
           'active-languages' => [
				   'es', 'fr', 'pt',
                                 ],
           'text' => $text,
           'mode' => 'dummy',
           });

