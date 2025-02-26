#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00-23:00:00
#SBATCH --account=def-yeaman

module load vcftools bcftools
module load StdEnv/2020 intel/2020.1.217 tabix/0.2.6


########### TO BE UPDATED with chosen filtering criteria ###########
### Filter the final VCF produced in script 10 
#################### This filtering is just an example, they are not the chosen criteria -- to be updated ###########


bcftools filter -e 'MQ < 30' bplaty.vcf.gz -Oz > tmp.vcf.gz

vcftools --gzvcf tmp.vcf.gz --max-missing 0.7 --minQ 30 --minGQ 20 --minDP 5 --max-alleles 2 --recode --recode-INFO-all --stdout > bplaty_filtered.vcf

rm tmp.vcf.gz


bgzip bplaty_filtered.vcf
tabix -p vcf bplaty_filtered.vcf.gz
