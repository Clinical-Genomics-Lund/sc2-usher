#!/bin/bash

# wget -O ref/public-latest.all.masked.ShUShER.pb.gz http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/public-latest.all.masked.ShUShER.pb.gz
wget -P ref/ http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/public-latest.all.masked.pb.gz --show-progress -O public-latest.all.masked.pb.gz
curl https://www.ecdc.europa.eu/sites/default/files/documents/PathogenVariant_public_mappings.csv > ref/PathogenVariant_public_mappings.csv
curl https://www.ecdc.europa.eu/sites/default/files/documents/PathogenVariant_public_mappings_VUM.csv > PathogenVariant_public_mappings_VUM.csv
