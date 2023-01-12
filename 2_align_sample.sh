#! /bin/bash 
#SBATCH --cpus-per-task=16
#SBATCH --mem=40gb
#SBATCH --time=7-00:00:00
#SBATCH -J 2_align_sample.sh
#SBATCH --error=align.SAMPLE.%J.err
#SBATCH --output=align.SAMPLE.%J.out

module load star/2.7.9a
sample=SAMPLE

trim1=ORIGEN_DATOS/${sample}/${sample}_reads1.fq.gz
trim2=ORIGEN_DATOS/${sample}/${sample}_reads2.fq.gz

readlength=75


call="STAR --runMode alignReads --runThreadN 16 --outSAMtype BAM Unsorted --readFilesCommand zcat --genomeDir $REF_GENOMEDIR --sjdbGTFfile $REF_GTF --outFileNamePrefix $sample  --readFilesIn  $trim1 $trim2 --quantMode TranscriptomeSAM --outFilterScoreMinOverLread 0.30 --outFilterMatchNminOverLread 0.30"

echo ${call}
eval ${call}

#CHECK grep "Finished on" SAMPLELog.final.out

