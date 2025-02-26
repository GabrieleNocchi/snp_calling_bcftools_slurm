#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00-23:00:00
#SBATCH --account=def-yeaman
#SBATCH --array=1-14


module load bcftools/1.11

CHROM=$(sed -n "${SLURM_ARRAY_TASK_ID}p" chromosomes.txt) ### list of chromosomes (can be found in the FASTA index file of reference genome -- .fai file). This species has 14, that's why array number is 14. We parallelize by chromosome. 

### If you have a very fragmented reference with 1000s of scaffolds, rather than sending 1000s of jobs, you can feed a list of chromosomes to the command rather than a single chromosome/scaffold name.

### So you can for example split 1000 scaffolds names into 10 lists of 100 scaffolds each, and feed those 10 lists to the command using a job array of size 10 (1-10) -- one list of scaffolds per job.


### Here we call SNPs. 

### list.txt is a list of ALL the realigned bam files of ALL samples. 

### If you have multiple bam per samples due to multiple libraries, merge them into one bam per sample before this step.

### ploidymap.txt is a list that keeps the same order of samples in list.txt and should use the sample ID names you set in script 05. 
### For each sample ID name has the ploidy -- for a diploid species just create a tab separated file with 2 columns (first column: sample ID name set in script 05, second columnd: 2)


bcftools mpileup -Ou -f Betula_pendula_subsp._pendula.fa --bam-list list.txt -q 5 -r $CHROM -I -a FMT/AD | bcftools call -S ploidymap.txt -G - -f GQ -mv -Ov > $CHROM\.vcf
