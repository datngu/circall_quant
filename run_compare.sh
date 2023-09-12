#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1                
#SBATCH --job-name=cscQTL
#SBATCH --mem=4G
#SBATCH --partition=gpu                
#SBATCH --mail-user=nguyen.thanh.dat@nmbu.no
#SBATCH --mail-type=ALL


#module load git/2.23.0-GCCcore-9.3.0-nodocs
module load Nextflow/21.03
module load singularity/rpm

export TOWER_ACCESS_TOKEN=eyJ0aWQiOiA3OTAxfS4xNGY5NTFmOWNiZmEwNjZhOGFkYzliZTg3MDc4YWI4ZTRiYTk4ZmI5
export NXF_SINGULARITY_CACHEDIR=/mnt/users/ngda/sofware/singularity


#reads="/mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz"


#nextflow run main.nf -resume -with-tower -profile cluster --reads "/mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz" --circRNA $PWD/data/simulated_circRNA_list.txt


nextflow run ciriquant.nf -resume -with-tower -profile cluster --reads "/mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz" --circRNA $PWD/data/simulated_circRNA_list.txt