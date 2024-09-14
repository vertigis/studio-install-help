#!/bin/bash

set -e
TZ=America/Los_Angeles
DATE=`date`
rm -rf dist zip
mkdir -p dist zip
cp -r static/. dist/.
cp -r static/. zip/.
cp -r *.ps1 *.sh ca-certs web-certs zip
rm -rf dist/index.html zip/index.html zip/build.sh
pandoc README.md -o zip/README.html --template static/index.html --toc --metadata=date="$DATE"
cp zip/README.html dist/index.html
cp -r *.ps1 *.sh *.yaml server ca-certs web-certs zip
pushd zip > /dev/null
tar -czf ../dist/deploy-studio.tgz .
zip -qr ../dist/deploy-studio.zip .
popd > /dev/null
