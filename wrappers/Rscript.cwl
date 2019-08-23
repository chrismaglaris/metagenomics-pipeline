cwlVersion: v1.0

class: CommandLineTool
baseCommand: []

inputs:
  R_command_to_execute:
    type: string
    inputBinding: 
      position: 0
    default: /usr/bin/Rscript
  script_to_execute:
    type: File
    inputBinding:
      position: 1
  metadata_file:
    type: File
    inputBinding:
      position: 2
      prefix: --args
  table_file:
    type: File
    inputBinding:
      position: 3
  taxonomy_file:
    type: File
    inputBinding:
      position: 4
  rooted_tree_file:
    type: File
    inputBinding:
      position: 5
  libraries_for_R_script:
    type: 
      type: array
      items: string
    inputBinding:
      position: 6
    default: []
outputs:
  phylogenetic_image:
    type: 
      type: array
      items: File
    outputBinding:
      glob: "*.png"