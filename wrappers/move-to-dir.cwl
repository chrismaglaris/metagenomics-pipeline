#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  filesGZ:
    type:
      type: array
      items: File
    default: []
  filesTXT:
    type:
      type: array
      items: File
    default: []
  filesHTML_pre:
    type:
      type: array
      items: File
    default: []
  filesZIP_pre:
    type:
      type: array
      items: File
    default: []
  filesHTML_post:
    type:
      type: array
      items: File
    default: []
  filesZIP_post:
    type:
      type: array
      items: File
    default: []
  barcodes:
    type: File
  dir_basename:
    type: string
    default: fastqc_trim_workflow
  qiime2_input_dir:
    type: string
    default: emp-paired-seq
expression: |
  ${

    var obj = {
      "output_dir": {
        "class": "Directory",
        "basename": inputs.dir_basename,
        "listing": inputs.filesTXT.concat(inputs.filesHTML_pre, inputs.filesZIP_pre, inputs.filesHTML_post, inputs.filesZIP_post)
      }
    };

    inputs.filesGZ[0].basename = "forward.fastq.gz";
    inputs.filesGZ[1].basename = "reverse.fastq.gz";
    inputs.filesGZ.push(inputs.barcodes);

    var output_dir2 = {
        "class": "Directory",
        "basename": inputs.qiime2_input_dir,
        "listing": inputs.filesGZ
      };

    return { 
      "output_dir": obj,
      "output_dir2": output_dir2
    };
  }
outputs:
  output_dir: Directory
  output_dir2: Directory