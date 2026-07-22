## MAGPIE (Multiclass + Fully Open Source Edition)
A LightGBM-based genetic variant classification system that integrates OpenFE and uses IterativeImputer for data imputation. This version has been optimized to run efficiently in memory-constrained environments and supports multiclass classification (Benign, VUS, Pathogenic).

### Basic Requirements 
1. Python 3.9+
2. Python packages listed in `requirements.txt`.
3. The SpliceAI library.

### Usage
The MAGPIE system reads variant input data in CSV format. Ensure that the first five columns of the table are named `Chr`, `Start`, `End`, `Ref`, and `Alt`. [Sample File](data/datasets/test.csv)

|  Chr  | Start |  End  |  Ref  |  Alt  |  ...  |
| ----- | ----- | ----- | ----- | ----- | ----- |
* Chr: chromosome identity of the genetic variant’s location.
* Start: starting coordinates of the genetic mutation.
* End: the end coordinate of the genetic mutation.
* Ref: the original nucleotide base from the reference genome.
* Alt: the mutated nucleotide base in the sample.
* CLASS: class (optional). -1 for Benign, 0 for Variant of Uncertain Significance, 1 for Pathogenic. 

#### Use a Pretrained Model to Predict Variants
The system reads and executes the model you previously trained using a multiclass dataset.

**Annotated Variants (If the input file is already annotated)**
Run this command:
`source magpie.sh --mode pred --test_file data/datasets/test.csv --file_state annotated --visualization`

**Unannotated Variants (If the input file is raw)**
Run this command:
`source magpie.sh --mode pred --test_file data/datasets/test.csv --file_state unannotated --visualization`

Classification results and performance metrics will be exported to the `data/result` and `data/output/visualization/` directories.

#### Train Model From Scratch (De Novo)
This version has eliminated dependencies on MATLAB and OMIM. The system is fully independent, using pure Python and public databases.

1.  Register to obtain the ANNOVAR software through their official website. Extract and place the Perl execution scripts (`table_annovar.pl`, etc.) in the `annovar/` directory.
2.  Run the `bash download.sh` command to automatically download the hg38 clinical database, the SpliceAI reference genome, ChromHMM, and GenCC (the OMIM replacement).
3.  Run the model training command using the Bash script:
    `source magpie.sh --mode train --input_file data/datasets/denovo.csv`

The trained model will be saved to the `data/result/MAGPIE.model` directory.
