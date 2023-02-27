#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83

INPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt)
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt)

module load picard java



java -jar $EBROOTPICARD/picard.jar MarkDuplicates INPUT=$INPUT OUTPUT=$OUTPUT\_dedup.bam METRICS_FILE=$INPUT\_DUP_metrics.txt VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=true
