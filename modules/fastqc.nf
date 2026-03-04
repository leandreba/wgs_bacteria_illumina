#!/usr/bin/env nextflow
//lsite des parametres par default si pas inscris 

//définis le process à executer (equivalent à une fonction entre gros guillemets)
process fastqc {
    
    input:
    path input
    
    script:
    
    """
    /opt/FastQC/fastqc --memory 2000 -t 8 '${input}' 
    """

    output:
    tuple path("*_fastqc.html"), path("*_fastqc.zip")
}


//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel
    fastqc_inputs = channel.fromPath(params.input).view()

    fastqc(fastqc_inputs)

    publish:
    fastqc_output = fastqc.out
}


//dire ou ranger les outputs de nos process
output {
    fastqc_output {
        path 'fastqc'
    }

}