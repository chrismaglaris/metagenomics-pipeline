#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "composition", "add-pseudocount"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  output_composition_table:
    type: string
    inputBinding:
      prefix: --o-composition-table
outputs: 
  composition_table:
    type: File
    outputBinding:
      glob: $(inputs.output_composition_table)