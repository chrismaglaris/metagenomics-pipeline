cwlVersion: v1.0
class: CommandLineTool

baseCommand: [mkdir, 123_dir]

inputs: []
outputs:
  dir:
    type: Directory
    outputBinding:
      glob: '123_dir'