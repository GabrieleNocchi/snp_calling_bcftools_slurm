#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=06-00:00:00
#SBATCH --account=def-yeaman

module load bcftools


bcftools concat -f list.txt -Oz > spruce_banff.vcf.gz
tabix -p vcf spruce_banff.vcf.gz
