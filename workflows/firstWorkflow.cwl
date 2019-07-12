#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  files:
    type:
      type: array
      items: File
    inputBinding:
      position: 1  
outputs: 
  fastqc_output_HTML_beforetrim:
    type:
      type: array
      items: File
    outputSource: fastqc1/fastqc_html_output
  fastqc_output_ZIP_beforetrim:
    type:
      type: array
      items: File
    outputSource: fastqc1/fastqc_zip_output
  outputGZar_trimgalore:
    type:
      type: array
      items: File
    outputSource: trim_galore/outputGZ
  outputTXTar_trimgalore:
    type:
      type: array
      items: File
    outputSource: trim_galore/outputTXT
  fastqc_output_HTML_aftertrim:
    type:
      type: array
      items: File
    outputSource: fastqc2/fastqc_html_output
  fastqc_output_ZIP_aftertrim::
    type:
      type: array
      items: File
    outputSource: fastqc2/fastqc_zip_output
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