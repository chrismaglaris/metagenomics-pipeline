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
  dir_basename:
    type: string
    default: fastqc_trim_workflow
expression: |
  ${
    return {"output_dir": {
      "class": "Directory", 
      "basename": inputs.dir_basename,
      "listing": inputs.filesGZ.concat(inputs.filesTXT, inputs.filesHTML_pre, inputs.filesZIP_pre, inputs.filesHTML_post, inputs.filesZIP_post)
    } };
  }
outputs:
  output_dir: Directory