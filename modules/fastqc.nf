#!/usr/bin/env nextflow
//lsite des parametres par default si pas inscris 

//définis le process à executer (equivalent à une fonction entre gros guillemets)
process fastqc {
    
    input:
    tuple val(id), path(reads)
    
    script:
    
    """
    /opt/FastQC/fastqc --memory 2000 -t 8 '${reads[0]}' '${reads[1]}' 
    """

    output:
    tuple val(id) ,path("*_fastqc.html") , path("*_fastqc.zip") //au format tupple car sinon on doit declarer nos output 1 par 1 apres dans publish 
}



//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel
    //fastqc_inputs = channel.fromPath(params.input).map {f -> tuple(f.baseName, f)}
    fastqc_inputs = channel.fromFilePairs("${params.input}*_R{1,2}_001*").view()
    fastqc(fastqc_inputs)

    publish:
    fastqc_output = fastqc.out
}


//dire ou ranger les outputs de nos process
output {
    fastqc_output {
        path { id -> "fastqc/${id}"}
    }

}