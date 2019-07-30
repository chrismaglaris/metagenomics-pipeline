#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["qiime", "tools", "import"]
inputs:
  input_type:
    type: string
    inputBinding:
      prefix: --type
    default: "SampleData[PairedEndSequencesWithQuality]"
  input_path:
    type: File
    inputBinding:
      prefix: --input-path
    default: .
  input_format:
    type: string
    inputBinding:
      prefix: --input-format
    default: PairedEndFastqManifestPhred33V2
  output_path:
    type: string
    inputBinding:
      prefix: --output-path
    default: paired-demux.qza
outputs: 
  artifact_tools_import:
    type: File
    outputBinding:
      glob: $(inputs.output_path)