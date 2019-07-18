#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "feature-table", "filter-samples"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  input_expr:
    type: string
    inputBinding:
      prefix: --p-where
  output_filtered_table:
    type: string
    inputBinding:
      prefix: --o-filtered-table
outputs: 
  filtered_table:
    type: File
    outputBinding:
      glob: $(inputs.output_filtered_table)