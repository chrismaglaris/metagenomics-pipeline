#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "metadata", "tabulate"]
inputs:
  input_stats_file:
    type: File
    inputBinding:
      prefix: --m-input-file
  output_stats_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  stats_visualization:
    type: File
    outputBinding:
      glob: $(inputs.output_stats_visualization)