#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["trim_galore", "--paired"]
inputs:
  files:
    type:
      type: array
      items: File
    inputBinding:
      position: 1    
outputs: 
  outputGZ:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.gz"
  outputTXT:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.txt"
arguments:
  - valueFrom: $(runtime.outdir)
    prefix: -o