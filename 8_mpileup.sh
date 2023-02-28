#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00-23:00:00
#SBATCH --account=def-yeaman
#SBATCH --array=1-14


module load bcftools/1.11

CHROM=$(sed -n "${SLURM_ARRAY_TASK_ID}p" chromosomes.txt)



bcftools mpileup -Ou -f Betula_pendula_subsp._pendula.fa --bam-list list.txt -q 5 -r $CHROM -I -a FMT/AD | bcftools call -S ploidymap.txt -G - -f GQ -mv -Ov > $CHROM\.vcf
