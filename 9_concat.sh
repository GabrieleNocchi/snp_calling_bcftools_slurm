#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00-23:00:00
#SBATCH --account=def-yeaman

module load vcftools bcftools
module load StdEnv/2020 intel/2020.1.217 tabix/0.2.6

vcf-concat Bpe_Chr1.vcf Bpe_Chr2.vcf Bpe_Chr3.vcf Bpe_Chr4.vcf Bpe_Chr5.vcf Bpe_Chr6.vcf Bpe_Chr7.vcf Bpe_Chr8.vcf Bpe_Chr9.vcf Bpe_Chr10.vcf Bpe_Chr11.vcf Bpe_Chr12.vcf Bpe_Chr13.vcf Bpe_Chr14.vcf > nocchi_bplaty.vcf


bgzip nocchi_bplaty.vcf
tabix -p vcf nocchi_bplaty.vcf.gz
