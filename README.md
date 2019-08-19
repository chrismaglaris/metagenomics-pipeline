# Project Title

In this project we built a metagenomics-pipeline.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

First, download and install the latest version of miniconda:

```
curl -O -L https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
Second, add the correct channels in the conda (so that it knows where to look for packages):

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```
Third, add Qiime2 enviroment:

```
wget https://data.qiime2.org/distro/core/qiime2-2019.7-py36-linux-conda.yml
conda env create -n qiime2-2019.7 --file qiime2-2019.7-py36-linux-conda.yml
```
Fourth, install CWL (Common Workflow Language) into Qiime2 enviroment:

```
wget https://data.qiime2.org/distro/core/qiime2-2019.7-py36-linux-conda.yml
conda env create -n qiime2-2019.7 --file qiime2-2019.7-py36-linux-conda.yml
```
Fifth, install the required tools into Qiime2 enviroment:

```
conda install -c bioconda fastqc trim-galore
```
Sixth, install R into Qiime2 enviroment:

```
Step 1: Add the CRAN gpg key:
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

Step 2: Add the CRAN repository for installing R:
$ sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

Step 3: Update repository index:
$ sudo apt-get update

Step 4: Install R Programming Language:
$ sudo apt-get install r-base

Step 5: Verify installation (optional):
$ R --version
```
Seventh, install the required libraries for phyloseq_tree.R into Qiime2 enviroment, into R:

```
sudo R

1. Install Bioconductor:
install.packages("BiocManager")
BiocManager::install()

2. Install library "qiime2R" :
install.packages("remotes")
remotes::install_github("jbisanz/qiime2R")

3. Install library "phyloseq" :
BiocManager::install("phyloseq")

4. Install library "tidyverse" :
install.packages("tidyverse")
```

## Running the tests

A test example:

```
source acrivate qiime2-2019.4
cwl-runner workflows/fastqc_trim_qiime2.cwl yaml_files/fastqc_trim_qiime2.yml
```

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details

