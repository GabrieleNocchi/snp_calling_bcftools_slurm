#!/bin/bash
#SBATCH --time=0-0:59
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --account=def-yeaman
#SBATCH --array=1-83


#### calculate depth statistics for 83 samples -- see array number above and change accordingly ####




# Load needed modules
module load samtools
module load bedtools
### Keep the lists below with the same order
INPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list1.txt)  ### list of realigned bam files
OUTPUT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" list2.txt)  ### list of output names (just extract from input names removing bam suffix)

# dump depth of coverage at every position in the genome
samtools depth -aa $INPUT > $OUTPUT\.depth

# gene depth analysis
echo \n">>> Computing depth of each gene for $file <<<"\n
awk '{print $1"\t"$2"\t"$2"\t"$3}' $OUTPUT\.depth | bedtools map -a genes.bed -b stdin -c 4 -o mean -null 0 -g genome.bed | awk -F "\t" '{print $1":"$2"-"$3"\t"$4}' | sort -k1,1 > $OUTPUT\-genes.tsv

# sort gene depth results based on input bed file
join -a 1 -e 0 -o '1.1 2.2' -t $'\t' genes.list $OUTPUT\-genes.tsv > $OUTPUT\-genes.sorted.tsv

# window depth analysis
echo \n">>> Computing depth of each window for $file <<<"\n
awk '{print $1"\t"$2"\t"$2"\t"$3}' $OUTPUT\.depth | bedtools map -a windows.bed -b stdin -c 4 -o mean -null 0 -g genome.bed | awk -F "\t" '{print $1":"$2"-"$3"\t"$4}' | sort -k1,1  > $OUTPUT\-windows.tsv

# sort window depth results based on input bed file
join -a 1 -e 0 -o '1.1 2.2' -t $'\t' windows.list $OUTPUT\-windows.tsv > $OUTPUT\-windows.sorted.tsv

# overall genome depth
echo \n">>> Computing depth of whole genome for $file <<<"\n
awk '{sum += $3; count++} END {if (count > 0) print sum/count; else print "No data"}' $OUTPUT\.depth > $OUTPUT\-wg.txt

echo " >>> Cleaning a bit...
"
rm -rf $OUTPUT\.depth
echo "
DONE! Check your files"
