#!/bin/bash

cd /sigma4/projects/cscqtl_revise/simualtion/circall_quant

export TOWER_ACCESS_TOKEN=eyJ0aWQiOiA3OTAxfS4xNGY5NTFmOWNiZmEwNjZhOGFkYzliZTg3MDc4YWI4ZTRiYTk4ZmI5


#cd /mnt/project/Aqua-Faang/dat/cscqtl/tcell_cscQTL_dev


reads="/mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz"


nextflow run main.nf -resume -with-tower --reads /mnt/project/Aqua-Faang/dat/cscqtl/simulation/*_{1,2}.fq.gz --circRNA $PWD/data/simulated_circRNA_list.txt
