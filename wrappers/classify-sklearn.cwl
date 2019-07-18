#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "feature-classifier", "classify-sklearn"]
inputs:
  input_classifier:
    type: File
    inputBinding:
      prefix: --i-classifier
  input_reads:
    type: File
    inputBinding:
      prefix: --i-reads
  output_classification:
    type: string
    inputBinding:
      prefix: --o-classification
outputs: 
  classification:
    type: File
    outputBinding:
      glob: $(inputs.output_classification)