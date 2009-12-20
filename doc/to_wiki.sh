#! /bin/bash -e

[ -d wiki ] || hg clone https://wiki.gnuplotutils.googlecode.com/hg/
hg -R wiki pull
hg -R wiki update
make gwiki
for i in *.gwiki; do
  cp -v $i ./wiki/${i%.gwiki}.wiki
done
