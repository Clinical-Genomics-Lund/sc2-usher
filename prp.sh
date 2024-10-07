#!/bin/bash

today=`date +%y%m%d`

# curl https://www.ecdc.europa.eu/sites/default/files/documents/PathogenVariant_public_mappings.csv > ref/PathogenVariant_public_mappings.csv
# curl https://www.ecdc.europa.eu/sites/default/files/documents/PathogenVariant_public_mappings_VUM.csv > ref/PathogenVariant_public_mappings_VUM.csv

printf "sample_id\tage\tsex\tct\tpangolin_type\tcollection_date\ttime_added\tselection_criterion\tVOI\tVUM\n" > meta_${today}.tsv

mongoexport --db=sarscov2 --collection=sample --type=json --fields=sample_id,pangolin,collection_date,selection_criterion,Ct,age,nextclade,sex,time_added --query='{"qc.qc_pass":{$eq:"TRUE"},time_added:{"$gte": ISODate("2023-06-01T00:00:00.000Z")}}' | jq -r '[.sample_id,.age,.sex,.Ct,.pangolin.type,.collection_date."$date",.time_added."$date",.selection_criterion]|@tsv' | sed -E 's/T..:..:..\..{1,3}Z//g' > meta_${today}_mongo.tsv

sed -i 's/&auml;/ä/' meta_${today}_mongo.tsv
sed -i 's/&ouml;/ö/' meta_${today}_mongo.tsv

sed -n '1,$p' meta_${today}_mongo.tsv | \
while read -r line ; do
	pango=$(echo $line | cut -f5 -d' ')
	if [[ $pango != '' ]] ; then
		voc=$(grep ${pango} ref/PathogenVariant_public_mappings.csv | cut -f1 -d',' | tr '\n' ',' | sed 's/,$//')
		vum=$(grep ${pango} ref/PathogenVariant_public_mappings_VUM.csv | cut -f1 -d',' | tr '\n' ',' | sed 's/,$//')
	fi
	printf "$line\t$voc\t$vum\n" >>  meta_${today}.tsv
done
