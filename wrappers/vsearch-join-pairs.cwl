#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "vsearch", "join-pairs"]
inputs:
  input_data:
    type: File
    inputBinding:
      prefix: --i-demultiplexed-seqs
  joined_seq_artifact:
    type: string
    inputBinding:
      prefix: --o-joined-sequences
    default: demux-single.qza
outputs: 
  joined-sequences:
    type: File
    outputBinding:
      glob: $(inputs.joined_seq_artifact)