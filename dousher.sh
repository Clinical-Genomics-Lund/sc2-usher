#!/bin/bash

today=`date +%y%m%d`

mafft --thread 10 --auto --keeplength --addfragments all_${today}.fa NC_045512v2.fa > allaligned_${today}.fa
faToVcf  -maskSites=problematic_sites_sarsCov2.vcf allaligned_${today}.fa allaligned.masked_${today}.vcf

usher -i new_global_assignments_prev.pb -v allaligned.masked_${today}.vcf -c -K 100 -T 40 -d ${today} -o new_global_assignments_${today}.pb

cp new_global_assignments_${today}.pb new_global_assignments_prev.pb
