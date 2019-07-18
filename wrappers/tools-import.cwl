#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "tools", "import"]
inputs:
  input_type:
    type: string
    inputBinding:
      prefix: --type
    default: "EMPSingleEndSequences"
  input_path:
    type: Directory
    inputBinding:
      prefix: --input-path
    default: .
  output_path:
    type: string
    inputBinding:
      prefix: --output-path
    default: emp-single-end-sequences.qza
outputs: 
  outpath:
    type: File
    outputBinding:
      glob: $(inputs.output_path)