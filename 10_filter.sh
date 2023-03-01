#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00-23:00:00
#SBATCH --account=def-yeaman

module load vcftools bcftools
module load StdEnv/2020 intel/2020.1.217 tabix/0.2.6

bcftools filter -e 'MQ < 30' *vcf.gz -Oz > tmp.vcf.gz

vcftools --gzvcf tmp.vcf.gz --max-missing 0.7 --minQ 30 --minGQ 20 --minDP 5 --max-alleles 2 --recode --recode-INFO-all --stdout > nocchi_bplaty_filtered.vcf

rm tmp.vcf.gz


bgzip nocchi_bplaty_filtered.vcf
tabix -p vcf nocchi_bplaty_filtered.vcf.gz
