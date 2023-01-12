#! /bin/bash 
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --time=7-00:00:00
#SBATCH -J 3_sort_bam.sh
#SBATCH --error=sort.SAMPLE.%J.err
#SBATCH --output=sort.SAMPLE.%J.out

module load samtools/1.13

bam=SAMPLEAligned.out.bam
obam=SAMPLEAligned.sorted.out.bam

call="samtools sort -n -o $obam $bam"

echo ${call}
eval ${call}

#CHECK ls SAMPLE*.sorted.out.bam
