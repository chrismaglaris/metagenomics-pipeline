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
    default: []
  dir_basename:
    type: string
expression: |
  ${

    var obj = {
      "output_dir": {
        "class": "Directory",
        "basename": inputs.dir_basename,
        "listing": inputs.files
      }
    };

    return { 
      "output_dir": obj
    };
  }
outputs:
  output_dir: Directory