#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=06-00:00:00
#SBATCH --account=def-yeaman

module load bcftools

### Concatenate all the chromsome vcfs produced in script 09. 
### list.txt is a list of the 14 (in this case) vcfs produced in script 09.
### Here we concatenate them in a single vcf

bcftools concat -f list.txt -Oz > bplaty.vcf.gz
tabix -p vcf bplaty.vcf.gz
