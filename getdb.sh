#!/bin/bash

# wget -O ref/public-latest.all.masked.ShUShER.pb.gz http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/public-latest.all.masked.ShUShER.pb.gz
# wget -P ref/ http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/public-latest.all.masked.pb.gz --show-progress -O public-latest.all.masked.pb.gz
curl http://hgdownload.soe.ucsc.edu/goldenPath/wuhCor1/UShER_SARS-CoV-2/public-latest.all.masked.pb.gz > ref/public-latest.all.masked.pb.gz
