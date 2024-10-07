#!/bin/bash

today=`date +%y%m%d`
startsec=$(date +%s)

mafft --thread 10 --auto --keeplength --addfragments all_${today}.fa NC_045512v2.fa > allaligned_${today}.fa
faToVcf  -maskSites=problematic_sites_sarsCov2.vcf allaligned_${today}.fa allaligned.masked_${today}.vcf

# usher -i new_global_assignments_prev.pb -v allaligned.masked_${today}.vcf -c -K 100 -T 40 -d ${today} -o new_global_assignments_${today}.pb
usher-sampled -i ref/public-latest.all.masked.pb.gz -v allaligned.masked_${today}.vcf -c -K 1000 -T 40 -k 50 --optimization_radius 0 -d ${today}

# cp new_global_assignments_${today}.pb new_global_assignments_prev.pb

endsec=$(date +%s)
let "timespent=$endsec-$startsec"
printf "all done in $timespent seconds\n"

# echo copying tree to clipboard
# cat ${today}/single-subtree.nh | xclip -se c
echo Copy data to Grapetree
echo "cat ${today}/single-subtree.nh | xclip -se c"
# read -n 1 -s
# echo copying metadata to clipboard
# cat meta_${today}.tsv | xclip -se c
echo "cat meta_${today}.tsv | xclip -se c"
