#!/usr/bin/perl

use strict;

my $fastqcOutputDir = $ARGV[0];
my $outputFile = $ARGV[1];

my @dataFiles = glob("$fastqcOutputDir/*/fastqc_data.txt");

my %results;
foreach(@dataFiles) {
    my $encoding = phred($_);
    $results{$encoding}++;
}

my @encodings = keys %results;
if(scalar @encodings != 1) {
    die "Could not determine mateA encoding";
}

open(OUT, ">$outputFile") or die "Could not open $outputFile for writing: $!";
print OUT $encodings[0];
close OUT;

sub phred {                                                                                                                                                          
    (my $fastqcFile) = @_;
    my %encoding = (
	"sanger" => "phred33",
	"illumina 1.3" => "phred64",
	"illumina 1.4" => "phred64",
	"illumina 1.5" => "phred64",
	"illumina 1.6" => "phred64",
	"illumina 1.7" => "phred64",
	"illumina 1.8" => "phred33",
	"illumina 1.9" => "phred33",
	"illumina 2"   => "phred33",
	"illumina 3"   => "phred33",
	"solexa" => "phred64"
	);
    my $phred;
    open (FH, $fastqcFile) or die "Cannot open $fastqcFile to determine phred encoding: $!";
    while (<FH>) {
	my $line = $_;
	if ($line =~ /encoding/i) {
	    foreach my $format (keys %encoding) {
		if ($line =~ /$format/i) {
		    if (! defined $phred) {
			$phred = $encoding{$format};
		    } elsif ($phred ne $encoding{$format}) {
			$phred = "Error: more than one encoding type";
		    }
		}
	    }
	    if (! defined $phred) {
		$phred = "Error: format not recognized on encoding line";
	    }
	}
    }
    if (! defined $phred) {
	$phred = "Error: encoding line not found in file";
    }
    close(FH);
    if ($phred =~ /error/i) {
	die "ERROR: Could not determine phred encoding: $phred";
    }
    return $phred;
}
