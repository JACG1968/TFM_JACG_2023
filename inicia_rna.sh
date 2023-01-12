module load aps

export EXPERIMENTO=rnaseq
export INPUTDIR=/path/to/workspace/rnaseq
export INPUTFILE=${INPUTDIR}/samples_to_process.lis
export JOB_SOURCE=${INPUTDIR}/jobs

export ORIGEN_DATOS=/path/to/rnaseq/samples

export REF_GENOMEDIR=${INPUTDIR}/references
export ADAPTERS_REF=${REF_GENOMEDIR}/nextera.fa.gz
export RIBOSOME_REF=${REF_GENOMEDIR}/ribosome.fa
export REF_GENOME=${REF_GENOMEDIR}/gencode_current_hg38_genome.fa
export REF_GTF=${REF_GENOMEDIR}/gencode_current_hg38_annotation.gtf
