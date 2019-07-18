#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "feature-table", "summarize"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-sample-metadata-file
  output_table_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  table_visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_table_visualization)