#!/usr/bin/bash

#####################################################################################
#Création du dossier containers, télécharmgement et extraction des images.
#####################################################################################
mkdir containers

cd containers

apptainer pull docker://staphb/fastqc:0.12.1
apptainer pull docker://staphb/fastp:1.1.0
apptainer pull docker://staphb/spades:4.2.0
apptainer pull docker://staphb/kraken2:2.17.1
apptainer pull docker://staphb/ncbi-amrfinderplus:4.2.7-2026-03-24.1
apptainer pull docker://staphb/bakta:1.12.0

cd ..

#####################################################################################
#Création du dossier qui stocke les databases et téléchargement/installation des DB.
#####################################################################################
mkdir db

cd db

wget -c https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08_GB_20260226.tar.gz
tar -xvf *.tar.gz

cd ..
