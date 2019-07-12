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
  out1:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.html"
  out2:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.zip"
arguments:
  - valueFrom: $(runtime.outdir)
    prefix: -o