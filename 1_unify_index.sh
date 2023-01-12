#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=40gb
#SBATCH --time=7-00:00:00
#SBATCH -J 1_unify_star_index_build.sh
#SBATCH --error=job.index_build.%J.err
#SBATCH --output=job.index_build.%J.out


module load star/2.7.9a

cd $REF_GENOMEDIR

readlength=74

STAR --runThreadN 16 --runMode genomeGenerate --genomeDir $REF_GENOMEDIR --genomeFastaFiles $REF_GENOME --sjdbGTFfile $REF_GTF --sjdbOverhang $readlength

#CHECK grep "Finished" job.index_build*.out
