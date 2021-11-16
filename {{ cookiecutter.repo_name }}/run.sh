#!/bin/bash

# script that will run snakemake on the max cluster

# SGE qsub settings:
#$ -V
#$ -cwd
#$ -j yes
#$ -l longrun
#$ -l m_mem_free=4G
#$ -l h_rt=168:0:0

# slurm sbatch settings:
#SBATCH --job-name=controljob_%j
#SBATCH --output=snakemake_%j.log
#SBATCH --partition=vcpu
#SBATCH --time=48:00:00
#SBATCH -c 1
#SBATCH --mem 2000

eval "$(conda shell.bash hook)"

conda activate snakemake

if [ -f mounts.txt ]; then
    >&2 echo "mounts.txt file is present..."
    while read s t; do
        MOUNT="${MOUNT}-B ${s}:${t} "
    done < mounts.txt
    >&2 echo "Adding the following mounts to singularity : \"${MOUNT}\""
fi

export SGE_ROOT="/opt/uge"
export PATH=${PATH}:"/usr/sbin"

# Start snakemake
snakemake --snakefile workflow/Snakefile \
          --use-singularity \
          --singularity-args "--nv ${MOUNT}" \
          --directory "${PWD}" \
          --profile {{scheduler}} \
          "$@"
          
