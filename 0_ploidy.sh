ls *1.fastq.gz | xargs -n 1 basename | sed 's/_1.fastq.gz//g' > ploidy_map/ploidymap.txt
for ind in $(cut -f1 ploidy_map/ploidymap.txt)
do
  sed -i "s/$ind/${ind}\t2/g" ploidy_map/ploidymap.txt
done


sort ploidy_map/ploidymap.txt > ploidy_map/p.txt
mv ploidy_map/p.txt ploidy_map/ploidymap.txt
