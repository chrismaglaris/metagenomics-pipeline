#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "taxa", "collapse"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_taxonomy:
    type: File
    inputBinding:
      prefix: --i-taxonomy
  input_level:
    type: int
    inputBinding:
      prefix: --p-level
  output_collapsed_table:
    type: string
    inputBinding:
      prefix: --o-collapsed-table
outputs: 
  collapsed_table:
    type: File
    outputBinding:
      glob: $(inputs.output_collapsed_table)