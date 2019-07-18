#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "feature-table", "tabulate-seqs"]
inputs:
  input_rep_seqs:
    type: File
    inputBinding:
      prefix: --i-data
  output_rep_seqs_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  rep_seqs_visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_rep_seqs_visualization)