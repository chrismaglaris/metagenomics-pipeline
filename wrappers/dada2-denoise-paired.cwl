#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "dada2", "denoise-paired"]
inputs:
  input_demux:
    type: File
    inputBinding:
      prefix: --i-demultiplexed-seqs
  trim_left_f:
    type: int
    inputBinding:
      prefix: --p-trim-left-f
  trunc_len_f:
    type: int
    inputBinding:
      prefix: --p-trunc-len-f
  trim_left_r:
    type: int
    inputBinding:
      prefix: --p-trim-left-r
  trunc_len_r:
    type: int
    inputBinding:
      prefix: --p-trunc-len-r
  output_rep_seq:
    type: string
    inputBinding:
      prefix: --o-representative-sequences
  output_table:
    type: string
    inputBinding:
      prefix: --o-table
  output_denoising_stats:
    type: string
    inputBinding:
      prefix: --o-denoising-stats
outputs: 
  rep_seq:
    type: File
    outputBinding:
      glob: $(inputs.output_rep_seq)
  table:
    type: File
    outputBinding:
      glob: $(inputs.output_table)
  denoising_stats:
    type: File
    outputBinding:
      glob: $(inputs.output_denoising_stats)