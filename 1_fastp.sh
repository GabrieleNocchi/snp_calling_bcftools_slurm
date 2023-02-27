#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83

INPUT1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt)
INPUT2=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt)
OUTPUT1=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list3.txt)
OUTPUT2=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list4.txt)


module load fastp


fastp -w  4 -i $INPUT1 -I $INPUT2 -o $OUTPUT1\_trimmed.fastq.gz -O $OUTPUT2\_trimmed.fastq.gz
