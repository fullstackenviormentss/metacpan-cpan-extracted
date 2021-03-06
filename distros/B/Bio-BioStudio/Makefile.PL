# Note: this file was auto-generated by Module::Build::Compat version 0.4214
require 5.006;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'INSTALLDIRS' => 'site',
  'VERSION_FROM' => 'lib/Bio/BioStudio.pm',
  'PL_FILES' => {},
  'EXE_FILES' => [
                   'bin/BS_AddFromGFF.pl',
                   'bin/BS_AddFromGenbank.pl',
                   'bin/BS_Cartoonist.pl',
                   'bin/BS_ChromosomeAnalyzer.pl',
                   'bin/BS_ChromosomeCutter.pl',
                   'bin/BS_ChromosomeDiff.pl',
                   'bin/BS_ChromosomeSegmenter.pl',
                   'bin/BS_ChromosomeSplicer.pl',
                   'bin/BS_CodonJuggler.pl',
                   'bin/BS_FirstGBrowse.pl',
                   'bin/BS_PCRTagDumper.pl',
                   'bin/BS_PCRTagger.pl',
                   'bin/BS_RepeatSmasher.pl',
                   'bin/BS_SeqChecker.pl',
                   'bin/BS_auto_codon_juggle.pl',
                   'bin/BS_auto_filter_enzymes.pl',
                   'bin/BS_auto_gather_enzymes.pl',
                   'bin/BS_auto_tag_genes.pl'
                 ],
  'NAME' => 'Bio::BioStudio',
  'PREREQ_PM' => {
                   'Text::Diff' => '1.3',
                   'URI::Escape' => '1.59',
                   'Readonly' => '2',
                   'Time::Format' => '1.11',
                   'Exception::Class' => '1.38',
                   'DBD::SQLite' => '1.48',
                   'Bio::Root::Root' => 0,
                   'Test::More' => 0,
                   'YAML::Tiny' => '1.5',
                   'Bio::GeneDesign' => '5'
                 }
)
;
