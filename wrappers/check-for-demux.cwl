#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
  file_multiplexed:
    type: File?
  file_demultiplexed:
    type: File?
expression: |
  ${
      if(inputs.file_multiplexed == null){
          var command = ["echo", "already_demultiplexed_data"];
          var demux = inputs.file_demultiplexed;
      } else {
          var command = ["qiime", "demux", "emp-paired"];
          var demux = inputs.file_multiplexed;
      }

    return { 
      "demux_command": command,
      "file_demultiplexed_seq": demux
    };
  }
outputs:
  demux_command: 
    type:
        type: array
        items: string
  file_demultiplexed_seq: 
    type: File?
