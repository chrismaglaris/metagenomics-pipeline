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
  outputHTML1:
    type:
      type: array
      items: File
    outputSource: fastqc1/out1
  outputZIP1:
    type:
      type: array
      items: File
    outputSource: fastqc1/out2
  outputGZar:
    type:
      type: array
      items: File
    outputSource: trim_galore/outputGZ
  outputTXTar:
    type:
      type: array
      items: File
    outputSource: trim_galore/outputTXT
  outputHTML2:
    type:
      type: array
      items: File
    outputSource: fastqc2/out1
  outputZIP2:
    type:
      type: array
      items: File
    outputSource: fastqc2/out2
steps:
  fastqc1:
    run: ../wrappers/fastqc.cwl
    in:
      files: files
    out: [out1, out2]
  trim_galore:
    run: ../wrappers/trim.cwl
    in:
      files: files
    out: [outputGZ, outputTXT]
  fastqc2:
    run: ../wrappers/fastqc.cwl
    in:
      files: trim_galore/outputGZ
    out: [out1, out2]