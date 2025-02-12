# Snakemake workflow: {{cookiecutter.project_name}}

[![Snakemake](https://img.shields.io/badge/snakemake-≥{{cookiecutter.min_snakemake_version}}-brightgreen.svg)](https://snakemake.bitbucket.io)
[![Build Status](https://travis-ci.org/snakemake-workflows/{{cookiecutter.repo_name}}.svg?branch=master)](https://travis-ci.org/snakemake-workflows/{{cookiecutter.repo_name}})

This is the template for a new Snakemake workflow. Replace this text with a comprehensive description covering the purpose and domain.
Insert your code into the respective folders, i.e. `scripts`, `rules`, and `envs`. Define the entry point of the workflow in the `Snakefile` and the main configuration in the `config.yaml` file.

## Authors

* {{cookiecutter.full_name}} (@{{cookiecutter.username}})

## Usage

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and, if available, its DOI (see above).

### Step 1: Obtain a copy of this workflow

1. Create a new github repository using this workflow [as a template](https://help.github.com/en/articles/creating-a-repository-from-a-template).
2. [Clone](https://help.github.com/en/articles/cloning-a-repository) the newly created repository to your local system, into the place where you want to perform the data analysis.

### Step 2: Configure workflow

Configure the workflow according to your needs via editing the files in the `config/` folder. Adjust `config.yaml` to configure the workflow execution, and `samples.tsv` to specify your sample setup.

Configure your snakemake cluster profile (`sge/config.yaml` or `slurm/config.yaml`) and the header lines in `run.sh`. 

### Step 3: Install Snakemake

Install Snakemake using [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html):

    conda create -c bioconda -c conda-forge -n snakemake mamba
    conda activate snakemake
    mamba install snakemake

For installation details, see the [instructions in the Snakemake documentation](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html).

### Step 4: Execute workflow

Activate the conda environment:

    conda activate snakemake

Test your configuration by performing a dry-run via

    bash run.sh -n 

Execute the workflow locally via

    snakemake -s workflow/Snakefile --cores $N

using `$N` cores. 

To submit a job that runs snakemake, you can use `run.sh`, which contains some sensible default parameters for the MDC max-cluster.

    # if using sge
    qsub run.sh <rule_name>
    # or
    qsub run.sh <requested/output/file>
    
    # if using slurm
    sbatch run.sh <rule_name>
    # or
    sbatch run.sh <requested/output/file>

See the [Snakemake documentation](https://snakemake.readthedocs.io/en/stable/executable.html) for further details.


## Testing

Test cases are in the subfolder `.test`. They are automatically executed via continuous integration with [Github Actions](https://github.com/features/actions).

