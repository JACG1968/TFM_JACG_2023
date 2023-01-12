#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=8gb
#SBATCH --time=7-00:00:00
#SBATCH -J 1_clean_sample.sh
#SBATCH --output=clean.SAMPLE.%J.out
#SBATCH --error=clean.SAMPLE.%J.err
module load bbmap/38.92
module load fastqc/0.11.9

sample=SAMPLE
fastq1=`echo ORIGEN_DATOS/${sample}*_R1_001.fastq.gz`
fastq2=`echo ORIGEN_DATOS/${sample}*_R2_001.fastq.gz`

fastqo1=$sample"_reads1.fq.gz"
fastqo2=$sample"_reads2.fq.gz"
stats=$sample"_stats.txt"

fastqc $fastq1 $fastq2

call="bbduk.sh -Xmx1g t=16 in=$fastq1 in2=$fastq2 ref=$ADAPTERS_REF ktrim=r k=23 mink=11 hdist=1 tpe tbo out=stdout.fq trimq=10 qtrim=rl minlength=35 | bbduk.sh -Xmx2g t=16 in=stdin.fq int=t out=$fastqo1 out2=$fastqo2 ref=$RIBOSOME_REF k=31 hdist=1 stats=$stats minavgquality=10 minlength=35"

echo $call
eval $call

fastqc $fastqo1 $fastqo2

#CHECK grep "Processing time" clean.SAMPLE.*.err
