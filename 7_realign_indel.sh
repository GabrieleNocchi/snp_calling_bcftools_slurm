#!/bin/bash
#SBATCH --time=1-10:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83

INPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt)
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt)

module load StdEnv/2020 samtools/1.12

samtools index $INPUT


module purge
module load nixpkgs/16.09
module load java gatk/3.8


# Realign
java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T RealignerTargetCreator -R Betula_pendula_subsp._pendula.fa -I $INPUT -o $OUTPUT\.intervals

java -jar $EBROOTGATK/GenomeAnalysisTK.jar -T IndelRealigner -R Betula_pendula_subsp._pendula.fa -I $INPUT -targetIntervals $OUTPUT\.intervals --consensusDeterminationModel USE_READS  -o $OUTPUT\_realigned.bam
