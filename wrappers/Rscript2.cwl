cwlVersion: v1.0

class: CommandLineTool
baseCommand: [sudo, Rscript, "/home/chris/Desktop/CWL/phyloseq_tree_1.R" ]
 
inputs:
    manifest_file:
      type: File
      inputBinding:
           position: 1
    table_file:
       type: File
       inputBinding:
           position: 2
    taxonomy_file:
       type: File
       inputBinding:
           position: 3
    rooted_tree_file:
       type: File
       inputBinding:
           position: 4
arguments: 
     prefix: --args
outputs:
  output:
    type: File
    outputBinding:
      glob: "*.png"

arguments:
  - valueFrom: $(runtime.outdir)
   
 

