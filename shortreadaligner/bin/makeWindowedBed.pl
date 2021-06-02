#!/usr/bin/env perl                                                                                                                        
use strict;
use warnings;
use Getopt::Long;

my ($samtoolsIndex, $winLen);

&GetOptions("samtoolsIndex=s" => \$samtoolsIndex,
            "winLen=s" => \$winLen);

open (BED, ">windows.bed") or die "Cannot open windows.bed for writing\n$!\n";
open (G, ">genome.txt") or die "Cannot open genome file for reading\n$!\n";
open (IN, "$samtoolsIndex") or die "Cannot open samtools index for reading\n$!\n";
while(<IN>) {
    my ($chr, $length, $cumulative, $lineLength, $lineBLength) = split(/\t/, $_);
    die "Chromosome and length are not defined for line $. in $samtoolsIndex. [$chr, $length]\n" unless(defined($chr) && defined($length));
    print G "$chr\t$length\n";
    for (my $i=1; $i+$winLen<=$length; $i+=$winLen) {
        if ($i+$winLen == $length) {
            printf BED "%s\t%d\t%d\n", $chr, $i, $length;
        } else {
            printf BED "%s\t%d\t%d\n", $chr, $i, $i+$winLen-1;
        }
    }
    printf BED "%s\t%d\t%d\n", $chr, $length-($length % $winLen)+1, $length unless ($length % $winLen <= 1);
}
close(IN);
close(BED);
close(G);
