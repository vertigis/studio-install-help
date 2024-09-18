#!/bin/bash

set -e
export TZ=America/Los_Angeles
DATE=`date`
rm -rf dist temp
mkdir -p dist temp
cp -r *.ps1 *.sh *.yaml static/. server ca-certs web-certs dist
rm -rf dist/README.html dist/README.md dist/build.sh
echo "Image / Tag,Date" > temp/summary.csv
jq -r '.[] | [.name, .date] | @csv' artifact/summary.json >> temp/summary.csv
pandoc temp/summary.csv -o temp/README.md   --from csv      --to gfm  --template README.md
pandoc temp/README.md   -o dist/README.html --from markdown --to html --template static/README.html --toc --metadata=date="$DATE"
pandoc temp/README.md   -o dist/README.md   --from markdown --to gfm  --template static/README.md   --toc --metadata=date="$DATE"
pushd dist > /dev/null
tar -czf ../temp/deploy-studio.tgz .
zip -qr ../temp/deploy-studio.zip .
popd > /dev/null
mv dist/README.html dist/index.html
mv temp/deploy-studio.* dist
