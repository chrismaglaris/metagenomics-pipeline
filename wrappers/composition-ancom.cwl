#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "composition", "ancom"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  input_metadata_column:
    type: string
    inputBinding:
      prefix: --m-metadata-column
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_visualization)