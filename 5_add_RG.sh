#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83

INPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt)
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt)
NAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list3.txt)
module load picard java

java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups I=$INPUT O=$OUTPUT\_RG.bam RGID=$NAME RGLB=$NAME\_LB RGPL=ILLUMINA RGPU=unit1 RGSM=$NAME
