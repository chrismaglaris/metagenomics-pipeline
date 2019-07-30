#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  raw_files:
    type:
      type: array
      items: File
  # barcodes_file:
  #   type: File
  FqcTr_dir_name:
    type: string
    default: fastqc_trim_workflow
  # qiime2_input_dir_name:
  #   type: string
  #   default: emp-paired-seq
outputs: 
  fastqc_trim_workflow_dir:
    type: Directory
    outputSource: create_workflows_directories/workflow_dir
  # qiime2_workflow_input_dir:
  #   type: Directory
  #   outputSource: create_workflows_directories/qiime2_workflow_dir
steps:
  fastqc_pre:
    run: ../wrappers/fastqc.cwl
    in:
      files: raw_files
    out: [fastqc_html_output, fastqc_zip_output]
  trim_galore:
    run: ../wrappers/trim.cwl
    in:
      files: raw_files
    out: [outputGZ, outputTXT]
  fastqc_post:
    run: ../wrappers/fastqc.cwl
    in:
      files: trim_galore/outputGZ
    out: [fastqc_html_output, fastqc_zip_output]
  create_workflows_directories:
    run: ../wrappers/move-to-dir.cwl
    in:
      # rawFiles: raw_files
      filesGZ: trim_galore/outputGZ
      filesTXT: trim_galore/outputTXT
      filesHTML_pre: fastqc_pre/fastqc_html_output
      filesZIP_pre: fastqc_pre/fastqc_zip_output
      filesHTML_post: fastqc_post/fastqc_html_output
      filesZIP_post: fastqc_post/fastqc_zip_output
      # barcodes: barcodes_file
      dir_basename: FqcTr_dir_name
      # qiime2_input_dir: qiime2_input_dir_name
    out: [workflow_dir]