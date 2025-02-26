#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83


#### All these lists below need to follow same order
INPUT1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt) ### List of trimmed R1 fastq reads (produced with script 01)
INPUT2=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt) ### List of trimmed R2 fastq reads (produced with script 01)
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list3.txt) ### List of output names -- extract the meaningful part of the name from the trimmed reads names. There is a single output file for each pair of reads (each sample or library)

module load bwa samtools

#### Here we map the trimmed reads to the ref genome and we produce a sam, then we convert it to bam, we sort it and finally we index it
#### We end up with 1 bam file per sample after this. If you had multiple libraries per sample, you'd end up with 1 bam per library


bwa mem -t 4 Betula_pendula_subsp._pendula.fa $INPUT1 $INPUT2  > ./bwa_output/$OUTPUT\.sam
samtools view -Sb -q 10 ./bwa_output/$OUTPUT\.sam > ./bwa_output/$OUTPUT\.bam
rm ./bwa_output/$OUTPUT\.sam
samtools sort --threads  4 ./bwa_output/$OUTPUT\.bam > ./bwa_output/$OUTPUT\_sorted.bam
rm ./bwa_output/$OUTPUT\.bam
samtools index ./bwa_output/$OUTPUT\_sorted.bam

