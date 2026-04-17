#!/usr/bin/env nextflow

process virulencefinder {

    input:
    tuple val(id), path(spades)
    
    script:
    
    """
    python3 -m virulencefinder -ifa ${spades}/contigs.fasta -o virulencefinder -x
    """

    output:
    tuple val(id), path("virulencefinder/*txt"), path("virulencefinder/*tsv")

}