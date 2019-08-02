#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: []
inputs:
  command_to_execute:
    type: 
      type: array
      items: string
    default: [echo, already_demultiplexed_data]
    inputBinding:
      position: 1
  input_seq:
    type: File?
    inputBinding:
      prefix: --i-seqs
      position: 2
  metadata_file:
    type: File?
    inputBinding:
      prefix: --m-barcodes-file
      position: 3
  barcode_column:
    type: string?
    inputBinding:
      prefix: --m-barcodes-column
      position: 4
    default: barcode-sequence
  output_demux:
    type: string?
    inputBinding:
      prefix: --o-per-sample-sequences
      position: 5
    default: demux-nikos.qza
  output_demux_details:
    type: string?
    inputBinding:
      prefix: --o-error-correction-details
      position: 6
    default: demux-details.qza
outputs: 
  demux:
    type: File?
    outputBinding:
      glob: $(inputs.output_demux)
  demux_details:
    type: File?
    outputBinding:
      glob: $(inputs.output_demux_details)