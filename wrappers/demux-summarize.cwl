#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "demux", "summarize"]
inputs:
  input_data:
    type: File
    inputBinding:
      prefix: --i-data
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  demux_visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_visualization)