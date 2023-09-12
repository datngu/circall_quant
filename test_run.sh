#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --nodes=1                
#SBATCH --job-name=cscQTL
#SBATCH --mem=4G
#SBATCH --partition=gpu                
#SBATCH --mail-user=nguyen.thanh.dat@nmbu.no
#SBATCH --mail-type=ALL


export TOWER_ACCESS_TOKEN=eyJ0aWQiOiA3OTAxfS4xNGY5NTFmOWNiZmEwNjZhOGFkYzliZTg3MDc4YWI4ZTRiYTk4ZmI5


#cd /mnt/project/Aqua-Faang/dat/cscqtl/tcell_cscQTL_dev


reads="/mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz"


nextflow run main.nf -resume -with-tower -profile cluster --reads /mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz --circRNA $PWD/data/simulated_circRNA_list.txt
