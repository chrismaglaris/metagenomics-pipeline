#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: SubworkflowFeatureRequirement
inputs:
  files:
    type:
      type: array
      items: File
  # barcodes:
  #   type: File
  pre_demux_file:
    type: File?
  post_demux_file:
    type: File?
  metadata:
    type: File
  classifier:
    type: File
  demux_barcode_column:
    type: string
    default: BarcodeSequence
  demux_artifact:
    type: string
    default: demux.qza
  demux_details_artifact:
    type: string
    default: demux-details.qza
  demux_visualization:
    type: string
    default: demux.qzv
  dada2_trim_left_f:
    type: int
    default: 0
  dada2_trunc_len_f:
    type: int
    default: 220
  dada2_trim_left_r:
    type: int
    default: 0
  dada2_trunc_len_r:
    type: int
    default: 200
  dada2_rep_seq_artifact:
    type: string
    default: rep-seqs.qza
  dada2_table_artifact:
    type: string
    default: table.qza
  dada2_stats_artifact:
    type: string
    default: stats-dada2.qza
  dada2_num_of_threads:
    type: int
    default: 24
  metadata_stats_visualization:
    type: string
    default: stats-dada2.qzv
  feature_table_summarize_visualization:
    type: string
    default: table.qzv
  feature_table_tabulate_seqs_visualization:
    type: string
    default: rep-seqs.qzv
  phylogeny_alignment_artifact:
    type: string
    default: aligned-rep-seqs.qza
  phylogeny_masked_alignment_artifact:
    type: string
    default: masked-aligned-rep-seqs.qza
  phylogeny_tree_artifact:
    type: string
    default: unrooted-tree.qza
  phylogeny_rooted_tree_artifact:
    type: string
    default: rooted-tree.qza
  diversity_sampling_depth:
    type: int
    default: 1103
  diversity_metrics_dir:
    type: string
    default: core-metrics-results
  rarefaction_max_depth:
    type: int
    default: 4000
  rarefaction_visualization:
    type: string
    default: alpha-rarefaction.qzv
  classifier_sklearn_artifact:
    type: string
    default: taxonomy.qza
  classifier_sklearn_visualization:
    type: string
    default: taxonomy.qzv
  taxa_barplot_visualization:
    type: string
    default: taxa-bar-plots.qzv
  feature_table_filter_samples:
    type: string
    default: "BodySite='gut'"
  feature_table_filter_samples_artifact:
    type: string
    default: gut-table.qza
  composition_add_pseudocount_artifact:
    type: string
    default: comp-gut-table.qza
  FqcTr_dir_name:
    type: string
    default: fastqc_trim_workflow
  # qiim2_input_dir_name:
  #   type: string
  #   default: emp-paired-seq
outputs: 
  Fqc_Tr_dir:
    type: Directory
    outputSource: fastqc_trim_galore/fastqc_trim_workflow_dir
  # GZ_files_dir:
  #   type: Directory
  #   outputSource: fastqc_trim_galore/qiime2_workflow_input_dir
  out_demux:
    type: File?
    outputSource: qiime2_workflow/o_demux_artifact
  out_demux_details:
    type: File?
    outputSource: qiime2_workflow/o_demux_details_artifact
  # out_demux_summarize:
  #   type: File
  #   outputSource: qiime2_workflow/o_demux_summarize_artifact
  out_dada2_rep_seq:
    type: File
    outputSource: qiime2_workflow/o_dada2_rep_seq_artifact
  out_dada2_table:
    type: File
    outputSource: qiime2_workflow/o_dada2_table_artifact
  out_dada2_denoising_stats:
    type: File
    outputSource: qiime2_workflow/o_dada2_denoising_stats_artifact
  # out_metadata_stats_visualization:
  #   type: File
  #   outputSource: qiime2_workflow/o_metadata_stats_visualization 
  # out_feature-table-summarize:
  #   type: File
  #   outputSource: qiime2_workflow/o_feature_table_summarize_visualization
  # out_feature-table-tabulate-seqs:
  #   type: File
  #   outputSource: qiime2_workflow/o_feature_table_tabulate_seqs_visualization
  out_phylogeny_alignment:
    type: File
    outputSource: qiime2_workflow/o_phylogeny_alignment_artifact
  out_phylogeny_masked_alignment:
    type: File
    outputSource: qiime2_workflow/o_phylogeny_masked_alignment_artifact
  out_phylogeny_tree:
    type: File
    outputSource: qiime2_workflow/o_phylogeny_unrooted_tree_artifact
  out_phylogeny_rooted_tree:
    type: File
    outputSource: qiime2_workflow/o_phylogeny_rooted_tree_artifact
  out_diversity_metrics_dir:
    type: Directory
    outputSource: qiime2_workflow/o_diversity_metrics_dir
  # out_alpha_rarefaction:
  #   type: File
  #   outputSource: qiime2_workflow/o_alpha_rarefaction_visualization
  out_classifier_sklearn:
    type: File
    outputSource: qiime2_workflow/o_classifier_sklearn_artifact
  out_phylogenetic_tree_image:
    type: File
    outputSource: create_im_phylogenetic_tree/output
  # out_classifier_sklearn_visualization:
  #   type: File
  #   outputSource: qiime2_workflow/o_classifier_sklearn_visualization
  # out_taxa_barplot_visualization:
  #   type: File
  #   outputSource: qiime2_workflow/o_taxa_barplot_visualization
  # out_feature_table_filter_samples_artifact:
  #   type: File
  #   outputSource: qiime2_workflow/o_feature_table_filter_samples_artifact
  # out_composition_table_visualization:
  #   type: File
  #   outputSource: qiime2_workflow/o_composition_table_visualization

steps:
  fastqc_trim_galore:
    run: ../workflows/fastqc_trim.cwl
    in:
      raw_files: files
      # barcodes_file: barcodes
    out: [fastqc_trim_workflow_dir]
  qiime2_workflow:
    run: ../workflows/qiime2_workflow.cwl
    in:
      post_demux_file: post_demux_file
      metadata_file: metadata
      classifier: classifier
      diversity_sampling_depth: diversity_sampling_depth
      rarefaction_max_depth: rarefaction_max_depth
    out: [o_demux_artifact, 
          o_demux_details_artifact,
          o_dada2_rep_seq_artifact, 
          o_dada2_table_artifact, 
          o_dada2_denoising_stats_artifact,
          o_phylogeny_alignment_artifact,
          o_phylogeny_masked_alignment_artifact, 
          o_phylogeny_unrooted_tree_artifact, 
          o_phylogeny_rooted_tree_artifact, 
          o_diversity_metrics_dir,
          o_classifier_sklearn_artifact]
  create_im_phylogenetic_tree:
    run: ../wrappers/Rscript2.cwl
    in:
      manifest_file: metadata
      table_file: qiime2_workflow/o_dada2_table_artifact
      taxonomy_file: qiime2_workflow/o_classifier_sklearn_artifact
      rooted_tree_file: qiime2_workflow/o_phylogeny_rooted_tree_artifact
    out: [output]