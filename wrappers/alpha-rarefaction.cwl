#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "diversity", "alpha-rarefaction"]
inputs:
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_phylogeny:
    type: File
    inputBinding:
      prefix: --i-phylogeny
  input_max_depth:
    type: int
    inputBinding:
      prefix: --p-max-depth
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  demux_visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_visualization)