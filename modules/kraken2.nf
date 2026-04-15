#!/usr/bin/env nextflow

process kraken2 {

    input:
    tuple val(id), path(clean_reads)
    val(threads)
    
    script:
    
    """
    k2 classify ${clean_reads[0]} ${clean_reads[1]} --db $projectDir/db/standard8/ --threads ${threads}  --report kraken.report --output kraken.output
    """

    output:
    tuple val(id), path("*.report"), path("*.output")

}