#!/bin/bash
#SBATCH --time=0-0:59
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --account=def-yeaman



#### Prepare Files needed for calculating depth ####



#### THIS IS NOT AN ARRAY; THE FILES CREATED HERE ARE USED FOR EVERY SAMPLE OF THE SAME SPECIES DATASET########################
##### NEED REF GENOME FASTA INDEX -- CAN CREATE WITH: samtools faidx reference.fasta
##### ALSO NEED GENES GFF FILE


# make a genomefile for bedtools
awk '{print $1"\t"$2}' *.fai > genome.bed

# make a BED file of 5000 bp windows from FASTA index
awk -v w=5000 '{chr = $1; chr_len = $2;
    for (start = 0; start < chr_len; start += w) {
        end = ((start + w) < chr_len ? (start + w) : chr_len);
        print chr "\t" start "\t" end;
    }
}' *.fai > windows.bed

# now make location list from window bedfile and sort for join
awk -F "\t" '{print $1":"$2"-"$3}' windows.bed | sort -k1,1 > windows.list

# and a bed file of each gene
awk '$3 == "gene" {print $1"\t"$4"\t"$5}' *gff | uniq > genes.bed

# we also sort this file based on the order of the reference index
cut -f1 *.fai | while read chr; do awk -v chr=$chr '$1 == chr {print $0}' genes.bed | sort -k2,2n; done > genes.sorted.bed
mv genes.sorted.bed genes.bed

# now make location list from sorted gene bedfile and sort for join
awk -F "\t" '{print $1":"$2"-"$3}' genes.bed | sort -k1,1 > genes.list
