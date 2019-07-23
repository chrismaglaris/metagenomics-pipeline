#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "diversity", "core-metrics-phylogenetic"]
inputs:
  input_rooted_tree:
    type: File
    inputBinding:
      prefix: --i-phylogeny
  input_table:
    type: File
    inputBinding:
      prefix: --i-table
  input_sampling_depth:
    type: int
    inputBinding:
      prefix: --p-sampling-depth
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  output_dir:
    type: string
    inputBinding:
      prefix: --output-dir
outputs: 
  phylogenetic_metrics_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.output_dir)