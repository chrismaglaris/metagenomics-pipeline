phyloseq_tree <- function(sample_metadata, table, taxonomy, rooted_tree) {
  library(tidyverse)
  library(qiime2R)
  library(phyloseq)
  
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
  
  # Taxonomic Filtering
  # ps = subset_taxa(physeq, !is.na(Phylum) & !Phylum %in% c("", "uncharacterized"))
  # 
  # # Compute prevalence of each feature, store as data.frame
  # prevdf = apply(X = otu_table(ps),
  #                MARGIN = ifelse(taxa_are_rows(ps), yes = 1, no = 2),
  #                FUN = function(x){sum(x > 0)})
  # 
  # # Add taxonomy and total read counts to this data.frame
  # prevdf = data.frame(Prevalence = prevdf,
  #                     TotalAbundance = taxa_sums(ps),
  #                     tax_table(ps))
  # 
  # # plyr::ddply(prevdf, "Phylum", function(df1){cbind(mean(df1$Prevalence),sum(df1$Prevalence))})
  # 
  # # Filter entries with unidentified Phylum.
  # # ps1 = subset_taxa(ps, !Phylum %in% c("Fusobacteria", "Deinococcus-Thermus")) 
  # 
  # # Prevalence Filtering
  # 
  # # Subset to the remaining phyla
  # prevdf1 = subset(prevdf) # , Phylum %in% get_taxa_unique(ps1, "Phylum")
  # 
  # # Define prevalence threshold as 5% of total samples
  # prevalenceThreshold = 0.05 * nsamples(ps)
  # 
  # # Execute prevalence filter, using `prune_taxa()` function
  # keepTaxa = rownames(prevdf1)[(prevdf1$Prevalence >= prevalenceThreshold)]
  # ps2 = prune_taxa(keepTaxa, ps)
  # 
  # ps3 = tax_glom(ps2, "Genus", NArm = TRUE)
  # 
  # h1 = 0.4
  # ps4 = tip_glom(ps3, h = h1)
  # 
  # ptree = plot_tree(ps4, color = "Sample", shape = "BodySite")
  # 
  # jpeg('treeplot.jpg', width = 1120, height = 664, units = "px", pointsize = 10, quality = 1000)
  # ptree
  # dev.off()
  # 
  # print(colnames(psmelt(ps4)))
  plot_tree(out, color = 'Family', shape = 'Sample', size = 'Abundance')
  return(physeq)
}