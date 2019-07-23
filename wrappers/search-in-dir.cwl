#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool
requirements:
  InlineJavascriptRequirement: {}
inputs:
    directory:
        type: Directory
    file_to_search:
        type: string
expression: |
  ${
      for(var i = 0; i < inputs.directory.listing.length; i++){
          var tempFile = inputs.directory.listing[i];

          if(tempFile.basename == inputs.file_to_search){
              var obj = tempFile;
              break;
          }
      }
      
      return {
          "output_file": obj
      };
  }
outputs:
  output_file: 
    type: File