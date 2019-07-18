#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  files:
    type:
      type: array
      items: File
  names:
    type:
      type: array
      items: string
      inputBinding:
        itemSeparator: ","
    default: [forward.fastq.gz, reverse.fastq.gz]
  dir_basename:
    type: string
    default: emp-paired-end-seq
expression: |
  ${  
    var obj = {
        "output_dir": {
            "class": "Directory",
            "basename": inputs.dir_basename,
            "listing": inputs.files 
            } };
    
    return obj;
  }
outputs:
  output_dir: Directory