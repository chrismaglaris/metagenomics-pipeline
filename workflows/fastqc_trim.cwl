#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  files:
    type:
      type: array
      items: File
  barcodes:
    type: File
  FqcTr_dir_name:
    type: string
    default: fastqc_trim_workflow
  qiim2_input_dir_name:
    type: string
    default: emp-paired-seq
outputs: 
  output_Fqc_Tr:
    type: Directory
    outputSource: create_fqc_tr_dir/output_dir
  output_GZ_files:
    type: Directory
    outputSource: create_fqc_tr_dir/output_dir2
steps:
  fastqc1:
    run: ../wrappers/fastqc.cwl
    in:
      files: files
    out: [fastqc_html_output, fastqc_zip_output]
  trim_galore:
    run: ../wrappers/trim.cwl
    in:
      files: files
    out: [outputGZ, outputTXT]
  fastqc2:
    run: ../wrappers/fastqc.cwl
    in:
      files: trim_galore/outputGZ
    out: [fastqc_html_output, fastqc_zip_output]
  create_fqc_tr_dir:
    run: ../wrappers/move-to-dir.cwl
    in:
      rawFiles: files
      filesGZ: trim_galore/outputGZ
      filesTXT: trim_galore/outputTXT
      filesHTML_pre: fastqc1/fastqc_html_output
      filesZIP_pre: fastqc1/fastqc_zip_output
      filesHTML_post: fastqc2/fastqc_html_output
      filesZIP_post: fastqc2/fastqc_zip_output
      barcodes: barcodes
    out: [output_dir, output_dir2]