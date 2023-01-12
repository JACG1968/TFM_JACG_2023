#! /bin/bash 
#SBATCH --cpus-per-task=42
#SBATCH --mem=60gb
#SBATCH --time=7-00:00:00
#SBATCH -J 4_unify_counts.sh
#SBATCH --error=counts.SAMPLE.%J.err
#SBATCH --output=counts.SAMPLE.%J.out 


module load anaconda/2021.05

call="featureCounts -O --verbose -s 2 -p --countReadPairs -T 34 -a ${REF_GTF} -o ${INPUTDIR}/featurecounts_table_ord.txt ${INPUTDIR}/*/*Aligned.sortedByCoord.out.bam"

echo ${call}
eval ${call}

#CHECK grep "Finished on" SAMPLELog.final.out
