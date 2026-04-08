include {fastqc} from './modules/fastqc.nf'
include {fastp} from './modules/fastp.nf'

//la base de notre worklfow on y appelle nos process
workflow {
    
    main:

    //on crée notre channel de reads bruts
    reads = channel.fromFilePairs("${params.input}*_R{1,2}_001*").view()
    
    fastqc(reads)
    fastp(reads)

    //On crée notre channel de reads cleans à partir de la sortie fastp
    fastp_output = fastp.out
    clean_reads = channel.of(fastp_output[id], fastp_output[R1], fastp_output[R2]).view()

    publish:
    fastqc_output = fastqc.out
    fastp_output = fastp.out
}


//dire ou ranger les outputs de nos process
output {
    fastqc_output {
        path { id, html, zip -> "${id}/fastqc"}
    }

    fastp_output {
        path {id, R1, R2, html, json -> "${id}/fastp"}
    }
}