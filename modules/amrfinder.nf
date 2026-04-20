#!/usr/bin/env nextflow

process amrfinder{

    input:
    tuple val(id), path(spades)
    val(threads)
    
    script:
    
    """
    amrfinder -n ${spades}/contigs.fasta -o ${id}_amrfound.tsv --name ${id} --threads ${threads}
    echo -e "# id: "${id}_amrfinder_hits" \n# parent_name: "AMRFinder detailed hits" \n# parent_description: "Détail des hits AMR détectés" \n# parent_id: "amrfinder_hits" \n# section_name: "${id}"\n# format: "tsv" \n# plot_type: "table" \n" > ${id}_mqc.tsv
    awk -F'\t' '{print \$7,"\t",\$8,"\t","\t",\$12,"\t",\$13,"\t",\$15,"\t",\$16,"\t",\$17}' *_amrfound.tsv >> ${id}_mqc.tsv
    """

    output:
    tuple val(id), path("*_amrfound.tsv"), path("*_mqc.tsv"), emit : report
    path("*_mqc.tsv"), emit : mqc

}