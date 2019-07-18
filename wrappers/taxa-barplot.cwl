#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "taxa", "barplot"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_taxonomy:
    type: File
    inputBinding:
      prefix: --i-taxonomy
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_visualization)