#!/bin/bash

#$ -V
#$ -cwd
#$ -j yes
#$ -l longrun
#$ -l m_mem_free=4G
#$ -l h_rt=168:0:0

test -d logs/cluster || { >&2 echo "logs/cluster does not exist"; exit 1; }

if [ -f mounts.txt ]; then
    >&2 echo "mounts.txt file is present..."
    while read s t; do
        MOUNT="${MOUNT}-B ${s}:${t} "
    done < mounts.txt
    >&2 echo "Adding the following mounts to singularity : \"${MOUNT}\""
fi

# Start snakemake
snakemake --snakefile workflow/Snakefile \
          --use-singularity \
          --singularity-args "--nv ${MOUNT}" \
          --cluster "qsub -V -cwd -pe smp {threads} -l m_mem_free={resources.mem} {resources.misc} -o ${sge_log_dir}{rule}.o\${{JOB_ID}} -j yes " \
          --directory "${PWD}" \
          --jobs 100 \
          --latency-wait 30 \
          --keep-going \
          "$@"
          
 
