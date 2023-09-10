#!/bin/bash
#SBATCH --time=0-0:50
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --account=def-yeaman


module load StdEnv/2020 samtools/1.12

samtools faidx Betula_pendula_subsp._pendula.fa


module purge
module load picard java


java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary R=Betula_pendula_subsp._pendula.fa O=Betula_pendula_subsp._pendula.dict

