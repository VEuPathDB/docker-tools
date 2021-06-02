#!/usr/bin/env python3

import vcf
import argparse

#NOTE this is currently specific to vcf files generated by VarScan. Other files may not have the correct attributes in the FORMAT field.
#Have put error handling in place to catch this in case we ever move away from Varscan
#In case we need to port this for another SNP caller:
#DP = total depth at position
#RD = reference depth
#AD = alt depth

def __main__():
    parser = argparse.ArgumentParser(description='Make a heterozygosity plot from a vcf file')
    parser.add_argument('--vcfFile', help='VCF file generated by VarScan', required=True)

    args = parser.parse_args()

    try:
        vcfReader = vcf.Reader(filename=args.vcfFile)
    except FileNotFoundError: 
        raise SystemExit('File {} cannot be found. Please check and try again\n'.format(args.vcfFile))

    try:
        vcfWriter = vcf.Writer(open('heterozygousSNPs.vcf', 'w'), vcfReader)
    except:
        raise SystemExit('File heterozygousSNPs.vcf cannot be opened for writing.\n')
    
            

    for record in vcfReader:
        # at the point where we run this in the workflow, we should only ever have one sample
        if len(record.samples) != 1:
            raise SystemExit ('VCF file {} has more than one sample. Please check you are using the correct VCF file\n')

        if 'AD' not in record.FORMAT or 'RD' not in record.FORMAT or 'DP' not in record.FORMAT:
            raise SystemExit('Record format is missing AD, RD or DP tags. Tags available in this file are "{0}". Please check that {1} was generated with VarScan\n'.format(record.FORMAT,args.vcfFile)) 

        sample = record.samples[0]
        ratio = (max(sample['AD'], sample['RD'])/sample['DP'])
        
        # this is our cutoff for being heterozygous (as used by YMAP)
        if ratio <= 0.75:
            print (record)
            vcfWriter.write_record(record)
    vcfWriter.close()


    exit()

if __name__=='__main__': __main__()
