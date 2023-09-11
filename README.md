# Circall_quant: fast circRNA quantification with Quasi-mapping


## 1. Introduction

This a a portable quantification module of cscQTL used for fast circRNA quantification with known highly confident circRNA candidates.

## 2. Installation
  

### 2.0 Hardware requirement

 

The pipeline requires at least a linux system with 32 CPUs and 32GB of RAM to run. You may customize the requiment in the main.nf but generally not recommended.

 

### 2.1 Dependency

  

Since Circall_quant is implemted with Nextflow (DSL2), you would need Nextflow to run it. Further information to install Nextflow can be found on its home page:[https://www.nextflow.io/](https://www.nextflow.io/)

  

For tool dependency, I have placed all dependencies in their corresponding container, so you would need to run with Docker or Singularity.


The default desgins of Circall_quant is running with either Docker using a single machine (**-profile standard**) or with sigularity using slurm HPC(**-profile cluster**), you may need to change the **nextflow.config** to adapt to the your system.

  

Further customization, I recommend to consult Nextflow homepage: [https://www.nextflow.io/docs/latest/config.html](https://www.nextflow.io/docs/latest/config.html)
  

### 2.2 Clone the pipeline

  

```sh

 
git clone  https://github.com/datngu/circall_quant.git


```

## 3. Parameters

  
| Parameters          | Description                                                                                                         | Default setting                        |
| :------------------ | :------------------------------------------------------------------------------------------------------------------ | :------------------------------------- |
| genome              | genome in fasta format                                                                                              | $baseDir/data/ref/genome.fa            |
| cdna                | transcripts (cDNA) in fasta format                                                                                  | $baseDir/data/ref/cdna.fa              |
| annotation          | ensembl annotation in gtf format                                                                                    | $baseDir/data/ref/annotation.gtf       |
| reads               | ribo minus RNA seq reads in fastq.gz format                                                                         | $baseDir/data/reads/\*\_{1,2}.fastq.gz |
| circRNA             | circRNA candidate list                                                                                              | $baseDir/data/circRNA_list.txt         |
| trace\_dir          | directory for tracing output - all intermediate files in the analyses will be soft-linked here - used for debugging | $baseDir/trace\_dir                    |
| outdir              | directory of output                                                                                                 | $baseDir/results                       |


## 4. Test example


<!-- If you run in a local computer with Docker:

```sh

nextflow run main.nf -resume --reads $reads --outdir "TEST_WITH_LOCAL" --genotype $genotype --consensus 3 --coloc true --circall true --ciri2 true --circexplorer2 true -with-report -profile standard


```

If you run in a HCP server with Singularity and Slurm:

```sh

nextflow run main.nf -resume --reads $reads --outdir "TEST_WITH_HPC" --genotype $genotype --consensus 3 --coloc true --circall true --ciri2 true --circexplorer2 true -with-report -profile cluster


``` -->



## 5. License
  
Circall_quant uses GNU General Public License GPL-3.


## 6. Reference

Dat Thanh Nguyen. 2023. "An integrative framework for circular RNA quantitative trait locus discovery with application in human T cells." bioRxiv 2023.03.22.533756; doi: https://doi.org/10.1101/2023.03.22.533756

Nguyen, D. T., Trac, Q. T., Nguyen, T. H., Nguyen, H. N., Ohad, N., Pawitan, Y., & Vu, T. N. (2021). Circall: fast and accurate methodology for discovery of circular RNAs from paired-end RNA-sequencing data. BMC bioinformatics, 22, 1-18.




















 