# fasta file
wget -O data/output/spliceai/hg38.fa.gz https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip data/output/spliceai/hg38.fa.gz

#chromHMM 15 core state
tar -zxvf data/annotation_database/master38.chromhmm.bedg.tar.gz

# AnnoVar annotation file
wget -O data/output/annovar/humandb/hg38_phastConsElements100way.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_phastConsElements100way.txt.gz
wget -O data/output/annovar/humandb/hg38_refGene.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_refGene.txt.gz
wget -O data/output/annovar/humandb/hg38_refGeneMrna.fa.gz http://www.openbioinformatics.org/annovar/download/hg38_refGeneMrna.fa.gz
wget -O data/output/annovar/humandb/hg38_refGeneVersion.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_refGeneVersion.txt.gz
wget -O data/output/annovar/humandb/hg38_dbnsfp33a.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_dbnsfp33a.txt.gz
wget -O data/output/annovar/humandb/hg38_dbnsfp33a.txt.idx.gz http://www.openbioinformatics.org/annovar/download/hg38_dbnsfp33a.txt.idx.gz
wget -O data/output/annovar/humandb/hg38_dbnsfp41a.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_dbnsfp41a.txt.gz
wget -O data/output/annovar/humandb/hg38_dbnsfp41a.txt.idx.gz http://www.openbioinformatics.org/annovar/download/hg38_dbnsfp41a.txt.idx.gz
wget -O data/output/annovar/humandb/hg38_gnomad30_genome.txt.gz http://www.openbioinformatics.org/annovar/download/hg38_gnomad30_genome.txt.gz
wget -O data/output/annovar/humandb/hg38_gnomad30_genome.txt.idx.gz http://www.openbioinformatics.org/annovar/download/hg38_gnomad30_genome.txt.idx.gz
gunzip data/output/annovar/humandb/hg38_phastConsElements100way.txt.gz
gunzip data/output/annovar/humandb/hg38_refGene.txt.gz
gunzip data/output/annovar/humandb/hg38_refGeneMrna.fa.gz
gunzip data/output/annovar/humandb/hg38_refGeneVersion.txt.gz
gunzip data/output/annovar/humandb/hg38_dbnsfp33a.txt.gz
gunzip data/output/annovar/humandb/hg38_dbnsfp33a.txt.idx.gz
gunzip data/output/annovar/humandb/hg38_dbnsfp41a.txt.gz
gunzip data/output/annovar/humandb/hg38_dbnsfp41a.txt.idx.gz
gunzip data/output/annovar/humandb/hg38_gnomad30_genome.txt.gz
gunzip data/output/annovar/humandb/hg38_gnomad30_genome.txt.idx.gz

# GenCC Database
GENCC_DIR="data/annotation_database"
mkdir -p "$GENCC_DIR"
HEADERS_FILE="$GENCC_DIR/gencc_headers.txt"
OUTPUT_FILE="$GENCC_DIR/gencc_submissions.csv"
URL="https://thegencc.org/download/action/submissions-export-csv?format=new"

if [ -f "$HEADERS_FILE" ] && [ -f "$OUTPUT_FILE" ]; then
  ETAG=$(grep -i '^ETag:' "$HEADERS_FILE" | sed 's/ETag: //i' | tr -d '"\r\n')
  HTTP_CODE=$(curl -s -D "$HEADERS_FILE" -H "If-None-Match: \"$ETAG\"" --write-out "%{http_code}" -o "$OUTPUT_FILE" "$URL")
  if [ "$HTTP_CODE" = "304" ]; then
    echo "Database GenCC sudah versi terbaru."
  elif [ "$HTTP_CODE" = "200" ]; then
    echo "Sukses memperbarui database GenCC."
  else
    echo "Menggunakan data lokal yang ada."
  fi
else
  curl -s -D "$HEADERS_FILE" -o "$OUTPUT_FILE" "$URL"
  echo "Database GenCC sukses disimpan."
fi

