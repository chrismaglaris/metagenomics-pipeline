#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "demux", "emp-paired"]
inputs:
  input_seq:
    type: File
    inputBinding:
      prefix: --i-seqs
  barcodes_file:
    type: File
    inputBinding:
      prefix: --m-barcodes-file
  barcode_column:
    type: string
    inputBinding:
      prefix: --m-barcodes-column
  output_demux:
    type: string
    inputBinding:
      prefix: --o-per-sample-sequences
  output_demux_details:
    type: string
    inputBinding:
      prefix: --o-error-correction-details
outputs: 
  demux:
    type: File
    outputBinding:
      glob: $(inputs.output_demux)
  demux_details:
    type: File
    outputBinding:
      glob: $(inputs.output_demux_details)