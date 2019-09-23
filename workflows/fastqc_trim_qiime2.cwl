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
    default: 13
  dada2_trunc_len_f:
    type: int
    default: 150
  dada2_trim_left_r:
    type: int
    default: 13
  dada2_trunc_len_r:
    type: int
    default: 150
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
    default: 0
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
  Rcommand_location:
    type: string
    default: /usr/bin/Rscript
  R_script_to_execute:
    type: File
  libraries_needed:
    type: 
      type: array
      items: string
    default: []
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
    type: 
      type: array
      items: File
    outputSource: create_image_phylogenetic_tree/phylogenetic_image
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
      FqcTr_dir_name: FqcTr_dir_name
      # barcodes_file: barcodes
    out: [fastqc_trim_workflow_dir]
  qiime2_workflow:
    run: ../workflows/qiime2_workflow.cwl
    in:
      pre_demux_file: pre_demux_file
      post_demux_file: post_demux_file
      metadata_file: metadata
      classifier: classifier
      demux_barcode_column: demux_barcode_column
      demux_artifact: demux_artifact
      demux_details_artifact: demux_details_artifact
      demux_visualization: demux_visualization
      dada2_trim_left_f: dada2_trim_left_f
      dada2_trim_left_r: dada2_trim_left_r
      dada2_trunc_len_f: dada2_trunc_len_f
      dada2_trunc_len_r: dada2_trunc_len_r
      dada2_rep_seq_artifact: dada2_rep_seq_artifact
      dada2_stats_artifact: dada2_stats_artifact
      dada2_table_artifact: dada2_table_artifact
      dada2_num_of_threads: dada2_num_of_threads
      metadata_stats_visualization: metadata_stats_visualization
      feature_table_summarize_visualization: feature_table_summarize_visualization
      feature_table_tabulate_seqs_visualization: feature_table_tabulate_seqs_visualization
      phylogeny_alignment_artifact: phylogeny_alignment_artifact
      phylogeny_masked_alignment_artifact: phylogeny_masked_alignment_artifact
      phylogeny_tree_artifact: phylogeny_tree_artifact
      phylogeny_rooted_tree_artifact: phylogeny_rooted_tree_artifact
      diversity_sampling_depth: diversity_sampling_depth
      diversity_metrics_dir: diversity_metrics_dir
      rarefaction_max_depth: rarefaction_max_depth
      classifier_sklearn_artifact: classifier_sklearn_artifact
      classifier_sklearn_visualization: classifier_sklearn_visualization
      taxa_barplot_visualization: taxa_barplot_visualization
      feature_table_filter_samples: feature_table_filter_samples
      feature_table_filter_samples_artifact: feature_table_filter_samples_artifact
      composition_add_pseudocount_artifact: composition_add_pseudocount_artifact
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
  create_image_phylogenetic_tree:
    run: ../wrappers/Rscript.cwl
    in:
      R_command_to_execute: Rcommand_location
      script_to_execute: R_script_to_execute
      metadata_file: metadata
      table_file: qiime2_workflow/o_dada2_table_artifact
      taxonomy_file: qiime2_workflow/o_classifier_sklearn_artifact
      rooted_tree_file: qiime2_workflow/o_phylogeny_rooted_tree_artifact
      libraries_for_R_script: libraries_needed
    out: [phylogenetic_image]