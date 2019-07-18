#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "diversity", "beta-group-significance"]
inputs:
  input_distance-matrix:
    type: File
    inputBinding:
      prefix: --i-distance-matrix
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  input_metadata-column:
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

arguments:
  - prefix: --p-pairwise"