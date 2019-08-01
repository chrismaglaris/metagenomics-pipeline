cwlVersion: v1.0

class: CommandLineTool
baseCommand: [ Rscript, "/home/chris/Desktop/CWL/phyloseq_tree_1.R" ]
 
inputs:

  files:
    type:
      type: array
      items: File
    inputBinding:
      position: 1
      prefix: --args

outputs:
  output:
    type: File
    outputBinding:
      glob: "*.png"

arguments:
  - valueFrom: $(runtime.outdir)
   
 

