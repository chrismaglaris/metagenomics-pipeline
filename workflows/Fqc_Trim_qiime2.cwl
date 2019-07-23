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
  Fqc_Tr_dir:
    type: Directory
    outputSource: fastqc_trim_galore/output_Fqc_Tr
  GZ_files_dir:
    type: Directory
    outputSource: fastqc_trim_galore/output_GZ_files
  artifact_tools_import:
    type: File
    outputSource: qiime2_workflow/o_artifact_tools_import

requirements:
  SubworkflowFeatureRequirement: {}

steps:
  fastqc_trim_galore:
    run: ../workflows/fastqc_trim.cwl
    in:
      files: files
      barcodes: barcodes
    out: [output_Fqc_Tr, output_GZ_files]
  qiime2_workflow:
    run: ../workflows/qiime2_workflow.cwl
    in:
      fastq_dir: fastqc_trim_galore/output_GZ_files
      barcodes: barcodes
    out: [o_artifact_tools_import]