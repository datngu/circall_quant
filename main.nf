#!/usr/bin/env nextflow
/*
========================================================================================
                Circall_quant: fast circRNA quantification with Quasi-mapping
            (part of cscQTL : consensus-based circRNA QTL analysis implememtation)
========================================================================================
 https://github.com/datngu/circall_quant
 Author: Dat T Nguyen
 Contact: ndat<at>utexas.edu
----------------------------------------------------------------------------------------
*/


/*
 Define the default parameters
*/ 


// general annotation
params.genome          = "$baseDir/data/ref/genome.fa"
params.cdna            = "$baseDir/data/ref/cdna.fa"
params.annotation      = "$baseDir/data/ref/annotation.gtf"
// RNA seqs
params.reads           = "$baseDir/data/reads/*_{1,2}.fastq.gz"
// circRNA list: list of highly confident circRNAs (typically consensus from various circRNA detection tools)
params.circRNA         = "$baseDir/data/simulated_circRNA_list.txt"
// outputs trace_dir is softlinked reuslts all of stages - for debugging, outdir is the main output (hard copied).
params.trace_dir       = "trace_dir"
params.outdir          = "results"




log.info """\
================================================================
                      nf-Circall_quant 
================================================================
    
    genome              : $params.genome
    cdna                : $params.cdna
    annotation          : $params.annotation

    reads               : $params.reads
    circRNA             : $params.circRNA

    outdir              : $params.outdir
    trace_dir           : $params.trace_dir

================================================================
"""


nextflow.enable.dsl=2

workflow {
    // general processing
    read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )
    CIRCALL_index_cdna(params.cdna)
    RECOUNT_get_peseudo_seqs(params.genome, params.circRNA)
    RECOUNT_index_peseudo_seqs(RECOUNT_get_peseudo_seqs.out)
    RECOUNT_count(RECOUNT_mapping.out)
}


process CIRCALL_index_cdna {
    container 'ndatth/rna-tools:v0.0.0'
    memory '32 GB'
    cpus 4

    input:
    path "cdna.fa"

    output:
    path "index_cdna"

    script:
    """
    TxIndexer -t cdna.fa -o index_cdna
    """
}




process RECOUNT_get_peseudo_seqs {
    container 'ndatth/rna-tools:v0.0.0'
    publishDir "${params.outdir}/recount_pseudo", mode: 'copy', overwrite: true
    memory '8 GB'
    cpus 1

    input:
    path genome
    path circRNA

    output:
    path "circRNA_consensus.fa"

    script:
    """
    generate_peseudo_BSJ_sequences.R genome=$genome circRNA=$circRNA out=circRNA_consensus.fa
    """
}


process RECOUNT_index_peseudo_seqs {
    container 'ndatth/rna-tools:v0.0.0'
    publishDir "${params.trace_dir}/recount_pseudo_idx", mode: 'symlink', overwrite: true
    memory '8 GB'
    cpus 1

    input:
    path circRNA_seq

    output:
    path "index_pseudo_seqs"

    script:
    """
    TxIndexer -t $circRNA_seq -o index_pseudo_seqs
    """
}


// edit CPU and RAM if needed
process RECOUNT_mapping {
    container 'ndatth/rna-tools:v0.0.0'
    publishDir "${params.outdir}/recount_mapping", mode: 'copy', overwrite: true
    memory '32 GB'
    cpus 32

    input:
    path "index_cdna"
    path "index_bsj" 
    tuple val(pair_id), path(reads)

    output:
    tuple val("${pair_id}"), path("${pair_id}_Circall_wt_fragmentInfo.txt"), path("${pair_id}_BSJ_mapped_read.txt")

    script:
    """
    Circall_recount.sh -txIdx index_cdna -bsjIdx index_bsj -read1 ${reads[0]} -read2 ${reads[1]} -o ${pair_id} -p ${task.cpus}
    """
}


process RECOUNT_count {
    container 'ndatth/rna-tools:v0.0.0'
    publishDir "${params.outdir}/recount", mode: 'copy', overwrite: true
    memory '4 GB'

    input:
    tuple val(pair_id), path(fragmentInfo), path(bsj_mapped_read)

    output:
    path "${pair_id}.recount"

    script:
    """
    recount_BSJ.py --bsj "${bsj_mapped_read}" --fragment --hit 50 --anchor 7 --info "${fragmentInfo}" --out "${pair_id}.recount"
    """
}

