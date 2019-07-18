#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  files:
    type:
      type: array
      items: File
  FqcTr_dir_name:
    type: string
    default: fastqc_trim_workflow
outputs: 
  output_Fqc_Tr:
    type: Directory
    outputSource: create_Fqc_Tr_dir/output_dir
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
  create_Fqc_Tr_dir:
    run: ../wrappers/move-to-dir.cwl
    in:
      filesGZ: trim_galore/outputGZ
      filesTXT: trim_galore/outputTXT
      filesHTML_pre: fastqc1/fastqc_html_output
      filesZIP_pre: fastqc1/fastqc_zip_output
      filesHTML_post: fastqc2/fastqc_html_output
      filesZIP_post: fastqc2/fastqc_zip_output
      dir_basename: FqcTr_dir_name
    out: [output_dir]