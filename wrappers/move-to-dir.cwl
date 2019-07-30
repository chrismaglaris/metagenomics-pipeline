#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  # rawFiles:
  #   type: 
  #     type: array
  #     items: File
  #   default: []
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
  # barcodes:
  #   type: File
  dir_basename:
    type: string
    default: fastqc_trim_workflow
  # qiime2_input_dir:
  #   type: string
  #   default: emp-paired-seq
expression: |
  ${
    var obj = {
      "workflow_dir": {
        "class": "Directory",
        "basename": inputs.dir_basename,
        "listing": inputs.filesTXT.concat(inputs.filesGZ, inputs.filesHTML_pre, inputs.filesZIP_pre, inputs.filesHTML_post, inputs.filesZIP_post)
      }
    };

    return { 
      "workflow_dir": obj
    };
  }
outputs:
  workflow_dir: Directory
  # qiime2_workflow_dir: Directory