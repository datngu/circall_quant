#!/bin/bash

cd /sigma4/projects/cscqtl_revise/simualtion/circall_quant

export TOWER_ACCESS_TOKEN=eyJ0aWQiOiA3OTAxfS4xNGY5NTFmOWNiZmEwNjZhOGFkYzliZTg3MDc4YWI4ZTRiYTk4ZmI5


#cd /mnt/project/Aqua-Faang/dat/cscqtl/tcell_cscQTL_dev


reads="/sigma4/projects/cscqtl_revise/simualtion/*_{1,2}.fq.gz"


nextflow run main.nf -resume -with-tower \
    --reads "/sigma4/projects/cscqtl_revise/simualtion/*_{1,2}.fq.gz" \
    --genome "/sigma4/data/genome_ref_GRCh37.75/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa" \
    --cdna "/sigma4/data/genome_ref_GRCh37.75/Homo_sapiens.GRCh37.75.cdna.all.fa" \
    --annotation "/sigma4/data/genome_ref_GRCh37.75/Homo_sapiens.GRCh37.75.gtf" \
    --circRNA "" \

