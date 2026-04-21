#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Statistics::Descriptive;
use List::MoreUtils qw { any };

my ($coverageFile, $chromosomes, $ploidy);
&GetOptions("coverageFile=s" => \$coverageFile,
	    "chromosomes=s" => \$chromosomes,
            "ploidy=i" => \$ploidy);

if (!$coverageFile || !$ploidy || !$chromosomes){
    die "usage: makeNormalisedCoverageFile --coverageFile <bed file of normalised coverage across genome in bins> --chromosomes <file of chromosomes to use for median calculation> --ploidy <base ploidy for genome>\n";
}

open (CHR, "$chromosomes") or die "Cannot open chromosomes file $chromosomes for reading\n$!\n";
my @chrs = map { s/\s+$//r } <CHR>;
close (CHR);

open (COV, "$coverageFile") or die "Cannot open coverage file $coverageFile for reading\n$!\n";
my $coverageValues;
my $coverages;
while (<COV>) {
    my ($chr, $start, $end, $coverage) = split (/\t/, $_);
    die "Line $_ in coverage file $coverageFile is incomplete\n" unless (defined ($chr) && defined ($start) && defined ($end) && defined ($coverage));
    push (@{$coverages}, ([$chr, $start, $end, $coverage]));
    # exclude unordered "bin" chromosomes from calculation of median
    if (any {$_ eq $chr} @chrs) {
        push (@{$coverageValues}, $coverage);
    }
}

die "No coverage values were collected — no chromosomes in $coverageFile matched those in $chromosomes\n" unless $coverageValues && @{$coverageValues};

my $constant = &getConstant($ploidy, $coverageValues);

# Make bed output
open (BED, ">normalisedCoverage.bed") or die "Cannot open bedgraph file normalisedCoverage.bed for writing\n$!\n";
foreach my $coverageLine (@{$coverages}) {
    my $cn = $constant*$coverageLine->[3];
    print BED "$coverageLine->[0]\t$coverageLine->[1]\t$coverageLine->[2]\t$cn\n";
}
close (BED);

# ==================================================================

sub getConstant {
    my ($ploidy, $coverageValues) = @_;
    my $stat = Statistics::Descriptive::Full->new();
    $stat->add_data(@{$coverageValues});
    return $ploidy/$stat->median();
}

exit;
