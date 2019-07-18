#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "emperor", "plot"]
inputs:
  input_pcoa:
    type: File
    inputBinding:
      prefix: --i-pcoa
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  input_custom-axes:
    type: string
    inputBinding:
      prefix: --p-custom-axes
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_visualization)