#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: fastqc
inputs:
  files:
    type:
      type: array
      items: File
    inputBinding:
      position: 1
outputs: 
  fastqc_html_output:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.html"
  fastqc_zip_output:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.zip"
arguments:
  - valueFrom: $(runtime.outdir)
    prefix: -o