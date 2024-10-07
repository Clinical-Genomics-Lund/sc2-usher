#!/bin/bash

today=`date +%y%m%d`
startsec=$(date +%s)

mafft --thread 10 --auto --keeplength --addfragments all_${today}.fa NC_045512v2.fa > allaligned_${today}.fa
faToVcf  -maskSites=problematic_sites_sarsCov2.vcf allaligned_${today}.fa allaligned.masked_${today}.vcf

# usher -i new_global_assignments_prev.pb -v allaligned.masked_${today}.vcf -c -K 100 -T 40 -d ${today} -o new_global_assignments_${today}.pb
time usher-sampled -i ref/public-latest.all.masked.pb.gz -v allaligned.masked_${today}.vcf -c -K 1000 -T 40 -k 50 -d ${today}-opt

# cp new_global_assignments_${today}.pb new_global_assignments_prev.pb

endsec=$(date +%s)
let "timespent=$endsec-$startsec"
printf "all done in $timespent seconds\n"

echo copying tree to clipboard
#cat ${today}/single-subtree.nh | xclip -se c
echo "cat ${today}/single-subtree.nh | xclip -se c"
echo paste into grapetree and then press any key
#read -n 1 -s
echo copying metadata to clipboard
#cat meta_${today}.tsv | xclip -se c
echo "cat meta_${today}.tsv | xclip -se c"
