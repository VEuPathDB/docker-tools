#!/usr/bin/env perl                                                                                                                        
use strict;
use warnings;
use Getopt::Long;

my ($bedFile, $summaryMetrics);

&GetOptions("bedFile=s" => \$bedFile,
            "summaryMetrics=s" => \$summaryMetrics);

open (F, "$summaryMetrics") or die  "Cannot open $summaryMetrics for reading\n";
my $totalReads;
while ( my $line = <F> ) {
    next unless $line =~/^PAIR|^UNPAIRED/;
    $totalReads = (split /\t/, $line)[5];
    chomp $totalReads
}
close(F);


open (B, "$bedFile") or die "Cannot open $bedFile for reading\n";
open (OUT, ">normalisedCoverage.bed") or die "Cannot open file normalisedCoverage.bed for writing\n";
while ( my $line = <B>) {
    chomp $line;
    my ($chr, $start, $end, $mapped, $numNonZero, $lenB, $propNonZero) = split(/\t/, $line);
    die "Chromosome, start and end coordinates or number of mapped reads are not defined\n" unless (defined($chr) && defined($start) && defined($end) && defined($mapped));
    $mapped = $mapped/$totalReads;
    printf OUT "%s\t%d\t%d\t%g\n", $chr, $start, $end, $mapped;
}
close(B);
close(OUT);
