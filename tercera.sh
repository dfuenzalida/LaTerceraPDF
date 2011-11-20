#!/bin/bash

# Requiere instalar wget y ghostscript. En Ubuntu o Debian:
# sudo aptitude install wget ghostscript

MAX_PAGES=100
DATE=`date +"%Y/%m/%d"`
OUTPUT=`date +"lt_%Y_%m_%d.pdf"`
COUNT=1

echo "*** Descargando paginas..."
while [ $COUNT -lt $MAX_PAGES ]; do
  NUM=`printf '%03d.pdf' $COUNT`

  if [ -f $NUM ]
  then
    echo "$NUM ya fue descargado"
  else
    wget -c -t 0 http://papeldigital.info/lt/$DATE/01/paginas/$NUM
  fi

  let COUNT=$COUNT+1
done

echo "*** Concatenando PDFs ..."
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$OUTPUT *.pdf

echo "*** Eliminando archivos intermedios ..."
rm 0*.pdf

echo "*** Listo: $OUTPUT"

