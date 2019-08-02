#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "dada2", "denoise-single"]
inputs:
  input_demux:
    type: File?
    inputBinding:
      prefix: --i-demultiplexed-seqs
  trim_left:
    type: int
    inputBinding:
      prefix: --p-trim-left
    default: 0
  trunc_len:
    type: int
    inputBinding:
      prefix: --p-trunc-len
    default: 120
  output_rep_seq:
    type: string
    inputBinding:
      prefix: --o-representative-sequences
    default: rep-seqs-dada2.qza
  output_table:
    type: string
    inputBinding:
      prefix: --o-table
    default: table-dada2.qza
  output_denoising_stats:
    type: string
    inputBinding:
      prefix: --o-denoising-stats
    default: stats-dada2.qza
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