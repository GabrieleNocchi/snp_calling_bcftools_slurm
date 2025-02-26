#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83


### The lists below need to follow the same order
INPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt) ### list of input bam files (output of script 03)
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt) ### list of output names --  I usually just remove the suffix (.bam) to extract the name from the input, and then the command below will add _dedup.bam 

module load picard java


### Here we remove duplicates. We feed it a bam, and we get a deduplicated bam per sample/library

java -jar $EBROOTPICARD/picard.jar MarkDuplicates INPUT=$INPUT OUTPUT=$OUTPUT\_dedup.bam METRICS_FILE=$INPUT\_DUP_metrics.txt VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=true
