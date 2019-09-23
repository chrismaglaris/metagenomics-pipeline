# Metagenomics - Pipeline

In this project we built a metagenomics-pipeline.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Qiime2 does not currently support Windows. 

In case a windows platform is required, we recommend using [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) or [Virtual Machines](https://docs.qiime2.org/2019.7/install/virtual/)

### Installing

Download and install the latest version of [miniconda](https://docs.conda.io/en/latest/miniconda.html):

```
curl -O -L https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
Add the correct channels in the conda (so that it knows where to look for packages):

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```
Install (and activate) [Qiime2](https://docs.qiime2.org/2019.7/install/native/) within a ```conda``` enviroment:

```
wget https://data.qiime2.org/distro/core/qiime2-2019.7-py36-linux-conda.yml
conda env create -n qiime2-2019.7 --file qiime2-2019.7-py36-linux-conda.yml
```
Install [CWL tool](https://github.com/common-workflow-language/cwltool) into Qiime2 enviroment:

```
conda install -c bioconda cwltool
```
Install required tools into Qiime2 enviroment:

```
conda install -c bioconda fastqc trim-galore
```
In case R is not installed in Qiime2 enviroment, please follow the instructions found here: https://cran.r-project.org/bin/linux/ubuntu/README.html
The following packages are required in order for the R scripts, which are used in the pipelines, to run properly:

- [```png```](https://cran.r-project.org/web/packages/png/index.html)
- [```readr```](https://cran.r-project.org/web/packages/png/index.html)
- [```tidyr```](https://cran.r-project.org/web/packages/tidyr/index.html)
- [```dplyr```](https://cran.r-project.org/web/packages/dplyr/index.html)
- [```tibble```](https://cran.r-project.org/web/packages/tibble/index.html)
- [```stringr```](https://cran.r-project.org/web/packages/stringr/index.html)
- [```qiime2R```](https://rdrr.io/github/jbisanz/qiime2R/)
- [```phyloseq```](https://bioconductor.org/packages/release/bioc/html/phyloseq.html)
- [```metacoder```](https://cran.r-project.org/web/packages/metacoder/index.html)
- [```cluster```](https://cran.r-project.org/web/packages/cluster/index.html)

## Documentation

For the [Common Workflow Language](https://www.commonwl.org/) please find instructions here: https://www.commonwl.org/user_guide/

Directories:

* ```R_scripts```   folder contains all R scripts which can be used from the pipeline created
* ```mapping```     folder contains all [metadata]((https://docs.qiime2.org/2018.11/tutorials/metadata/)) files 
* ```workflows```   folder contains all pipelines which have been created
* ```wrappers```    folder contains all wrappers which are used from the workflows
* ```yaml_files```  folder contains all YAML files that are used as input for the pipelines
 

## Usage

1. Create a new directory and place all ```fastq``` files in it

2. Create a metadata file (see ```mapping/manifest``` for an example)

3. [Import your data](https://docs.qiime2.org/2019.7/tutorials/importing/) as a Qiime2 artifact

4. Create a new [classifier](https://docs.qiime2.org/2018.11/data-resources/) or use a pre-trained one

5. Give all paths of your files and any other desirable input in ```yaml_files/fastqc_trim_qiime2.yml```

Run the following command:

```
cwl-runner workflows/fastqc_trim_qiime2.cwl yaml_files/fastqc_trim_qiime2.yml
```

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details

