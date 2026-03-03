#!/usr/bin/env nextflow

process fastqc {
    
    input:
    path chemin
    
    script:
    
    """
    /opt/FastQC/fastqc --memory 2000 -t 8 ${chemin} 
    """

    output:
    path '*_fastqc.html'
    path '*_fastqc.zip'
}

workflow {
    main:
    fastqc(params.input)

    publish:
    first_output = fastqc.out
}

output {
    first_output {
        path '.'
    }
}