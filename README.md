

## Run this pipeline:

1) Download this repository
2) Set up the required software ( see list below )
2) Put sequences in the input dir (/BaseSpace)
3) Create a local.properties file.  See local_TEMPLATE.properties.  If none of these properties apply, the file may be blank, or removed from the config file.

```
biolockj processMiSeqs.config
```

See `biolockj --help` for additional options.

** higlighted options **

To run in docker: 
```
biolockj -d processMiSeqs.config
```

To create output in this pipelines folder (as opposed to your default: $BLJ_PROJ dir):
```
biolockj --blj_proj $PWD/pipelines processMiSeq.config
```
This command is assumes your current working directory is the repository root.


### Required software

Option A:

 * [BioLockJ](https://github.com/BioLockJ-Dev-Team/BioLockJ)
 * [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
 * [BBTools](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/installation-guide/) , specifically [bbmerge](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbmerge-guide/)
 * [RDP classifier](https://sourceforge.net/projects/rdp-classifier/)
 * [R (r-project.org) ](https://www.r-project.org/)
 

Option B:

 * [BioLockJ](https://github.com/BioLockJ-Dev-Team/BioLockJ)
 * [Docker](https://docs.docker.com/get-docker/)