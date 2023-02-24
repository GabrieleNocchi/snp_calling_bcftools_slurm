#!/bin/bash
#SBATCH --time=0-6:00
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --account=def-yeaman


module load bwa 


bwa index -a bwtsw Betula_pendula_subsp._pendula.faa
