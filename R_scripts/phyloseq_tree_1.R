phyloseq_tree_1 <- function(sample_metadata, table, taxonomy, rooted_tree) {

  library(ggplot2)
  library(dplyr)
  library(tidyr)
  library(readr)
  library(purrr)
  library(tibble)
  library(stringr)
  library(forcats)
  library(qiime2R)
  library(phyloseq)
  library(png)
  
  library(metacoder)
  library(cluster)
  
  ## Reading data
  
  metadata = read_tsv(sample_metadata)
  SVs = read_qza(table)
  taxonomy = read_qza(taxonomy)
  taxtable = taxonomy$data %>% separate(Taxon, sep="; ", c("Kingdom","Phylum","Class","Order","Family","Genus","Species"))
  tree = read_qza(rooted_tree)
  
  ## Bulding phylogenetic tree
  
  physeq = phyloseq(otu_table(SVs$data, taxa_are_rows = T),
                    phy_tree(tree$data), 
                    tax_table(as.data.frame(taxtable) %>% select(-Confidence) %>% column_to_rownames("Feature.ID") %>% as.matrix()), 
                    sample_data(metadata %>% column_to_rownames(colnames(metadata)[1])))
  
  ptree = plot_tree(physeq, color = 'Sample', size = 'Abundance')
  
  png("treeplot.png", width = 2452, height = 1480)
  print(ptree)
  dev.off()
  
  ## Clustering
  
  SVs = SVs$data
  SVs = as.data.frame(SVs)
  SVs = t(SVs)
  d = dist(SVs)
  silhScore = c()
  
  metadata = as.data.frame(metadata)
  
  for(num in 2:(nrow(SVs) - 1)){
    clusters = kmeans(SVs, centers = num)
    ss = silhouette(clusters$cluster, d)
    silhScore = c(silhScore, mean(ss[ ,3]))
  }
  
  maxNumClusters = c(2:(nrow(SVs) - 1))
  maxNumClusters = maxNumClusters[which(silhScore == max(silhScore))]
  
  clusters = kmeans(SVs, centers = maxNumClusters)
  clusters = as.data.frame(clusters$cluster)
  colnames(clusters) = "Clusters"
  
  clusters = clusters[sort(rownames(clusters)), ]
  
  rownames(metadata) = metadata$`sample-id`
  metadata = metadata[sort(metadata$`sample-id`), ]
  
  metadata = cbind(metadata, clusters)
  
  hc = hclust(d)
  
  png("hierarchicalTree.png", width = 2452, height = 1480)
  plot(hc)
  dev.off()
  
  ## Statistical significance of clusters
  
  taxon = taxonomy$data$Taxon
  taxon = str_remove(taxon, "; s__")
  
  otutable = otu_table(physeq)
  otutable = as.data.frame(otutable)
  otutable = cbind(data.frame(Taxon = taxon), otutable)
  otutable = otutable[!str_detect(otutable$Taxon, "Unassigned"), ]
  
  obj <- parse_tax_data(otutable,
                        class_cols = "Taxon",                        # the column that contains taxonomic information
                        class_sep = "; ",                            # The character used to separate taxa in the classification
                        class_regex = "^(.+)__(.+)$",                # Regex identifying where the data for each taxon is
                        class_key = c(tax_rank = "info",             # A key describing each regex capture group
                                      tax_name = "taxon_name"))
  
  names = metadata$`sample-id`
  metadata$clusters = ifelse(metadata$clusters == 1, "Group_1", "Group_2")
  
  obj$data$tax_data = zero_low_counts(obj, data = "tax_data", min_count = 5)
  no_reads = rowSums(obj$data$tax_data[, names]) == 0
  obj = filter_obs(obj, data = "tax_data", ! no_reads, drop_taxa = TRUE)
  obj$data$tax_data = calc_obs_props(obj, "tax_data")
  
  obj$data$tax_abund <- calc_taxon_abund(obj, "tax_data", cols = names)
  obj$data$tax_occ <- calc_n_samples(obj, "tax_abund", groups = metadata$clusters)
  
  obj$data$diff_table <- compare_groups(obj,
                                        dataset = "tax_abund",
                                        cols = metadata$`sample-id`,  # What columns of sample data to use
                                        groups = metadata$clusters)   # What category each sample is assigned to
  
  significanceTree = heat_tree(obj, 
                                node_label = taxon_names,
                                node_size = n_obs,                           # n_obs is a function that calculates, in this case, the number of OTUs per taxon
                                node_color = mean_diff,                      # A column from `obj$data$diff_table`
                                node_color_interval = c(-0.2, 0.2),          # The range of `log2_median_ratio` to display
                                node_color_range = c("cyan", "gray", "tan"), # The color palette used
                                node_size_axis_label = "OTU count",
                                node_color_axis_label = "mean_diff",
                                layout = "davidson-harel",                   # The primary layout algorithm
                                initial_layout = "reingold-tilford")         # The layout algorithm that initializes node locations
  
  png("significanceTree.png", width = 2452, height = 1480)
  print(significanceTree)
  dev.off()
  
  return(physeq)
}