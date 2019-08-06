phyloseq_tree = function(sample_metadata, table, taxonomy, rooted_tree, libraries) { 
	
  .libPaths(c(.libPaths(), libraries))

  library(dplyr)
  library(tidyr)
  library(magrittr)
  library(readr)
  library(purrr)
  library(tibble)
  library(stringr)
  library(forcats)
  library(qiime2R)
  library(phyloseq)
  library(png)
  
  metadata = read_tsv(sample_metadata)
  SVs = read_qza(table)
  taxonomy = read_qza(taxonomy)
  
  #convert the table into a tabular split version
  taxtable = taxonomy$data %>% separate(Taxon, sep="; ", c("Kingdom","Phylum","Class","Order","Family","Genus","Species"))
  tree = read_qza(rooted_tree)

  physeq = phyloseq(otu_table(SVs$data, taxa_are_rows = T),
                    phy_tree(tree$data), 
                    tax_table(as.data.frame(taxtable) %>% select(-Confidence) %>% column_to_rownames("Feature.ID") %>% as.matrix()), 
                    sample_data(metadata %>% column_to_rownames(colnames(metadata)[1])))
  
  ptree = plot_tree(physeq, color = 'Kingdom', shape = 'Sample', size = 'Abundance')
  
  png("treeplot.png", width = 1120, height = 664)
  print(ptree)
  dev.off()
}

args = commandArgs(trailingOnly=TRUE);
args = args[2:length(args)]
a = args[1]
b = args[2]
c = args[3]
d = args[4]
libraries = args[5:length(args)]
phyloseq_tree(a, b, c, d, libraries)