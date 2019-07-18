#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "diversity", "alpha-group-significance"]
inputs:
  input_alpha-diversity:
    type: File
    inputBinding:
      prefix: --i-alpha-diversity
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