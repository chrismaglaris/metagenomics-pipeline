#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement
baseCommand: ["qiime", "diversity", "alpha-group-significance"]
inputs:
  input_alpha-diversity:
    type: File
    inputBinding:
      prefix: --i-alpha-diversity
  input_metadata:
    type: File
    inputBinding:
      prefix: --m-metadata-file
  output_visualization:
    type: string
    inputBinding:
      prefix: --o-visualization
outputs: 
  visualization:
    type: Directory
    expression: |
        ${
            return {
                "visualization": {
                    "class": "Directory", 
                    "basename": "core-metrics-results",
                    "listing": [inputs.output_visualization]
                }
            };
        }