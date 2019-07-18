#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "phylogeny", "align-to-tree-mafft-fasttree"]
inputs:
  input_rep_seqs:
    type: File
    inputBinding:
      prefix: --i-sequences
  output_alignment:
    type: string
    inputBinding:
      prefix: --o-alignment
  output_masked_alignment:
    type: string
    inputBinding:
      prefix: --o-masked-alignment
  output_tree:
    type: string
    inputBinding:
      prefix: --o-tree
  output_rooted_tree:
    type: string
    inputBinding:
      prefix: --o-rooted-tree
outputs: 
  alignment:
    type: File
    outputBinding:
      glob: $(inputs.output_alignment)
  masked_alignment:
    type: File
    outputBinding:
      glob: $(inputs.output_masked_alignment)
  tree:
    type: File
    outputBinding:
      glob: $(inputs.output_tree)
  rooted_tree:
    type: File
    outputBinding:
      glob: $(inputs.output_rooted_tree)