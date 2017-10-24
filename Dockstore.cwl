#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [java]

doc: "run mitcr"

hints:
  DockerRequirement:
    dockerPull: mitcr

requirements:
  - class: InlineJavascriptRequirement

inputs:

# Do we want to seprate this
#  java_memory:
#    type: string
#    default: "10g"
#    inputBinding:
#      position: 1
#      prefix: -Xmx
#      itemSeparator: ""

  java_memory:
    type: string
    default: "-Xmx10g"
    inputBinding:
      position: 1
    doc: java runtime maximum heap size

# path in docker image is set as a default argument
  jar_file_path:
    type: string
    default: "/home/ubuntu/mitcr-1.0.3.jar"
    inputBinding:
      position: 2
      prefix: -jar
    doc: path to jar file in docker image

  pset:
    type: string
    default: "flex"
    inputBinding:
      position: 3
      prefix: --pset
    doc: "flex" is the default setting for mitcr, also see "jprimer"

  input_fastq:
    type: File
    inputBinding:
      position: 4
    doc: MiTCR accepts sequencing data in the fastq format. It can also 
      directly read the data from a gzip ­compressed input file (file name must
      end with “.gz”). Sequence quality information in the fastq file can be
      coded with byte offset equal to 33 (Sanger) or 64 (Solexa), in the later
      case additional ­solexa option should be added to the parameters list.

  output_string:
    type: string
    default: "output.txt"
    inputBinding:
      position: 5
    doc: name of output file

  species:
    type: ["null", string]
    inputBinding:
      prefix: -species
    doc: overrides target species

  gene:
    type: ["null", string]
    inputBinding:
      prefix: -gene
    doc: overrides target gene

  cysphe:
    type: ["null", int]
    inputBinding:
      prefix: -cysphe
    doc: overrides CDR3 definition. Determines whether to include bounding
      cysteine and phenylalanine into CDR3

  ec:
    type: ["null", int]
    inputBinding:
      prefix: -ec
    doc: overrides the error correction level

  quality:
    type: ["null", int]
    inputBinding:
      prefix: -quality
    doc: overrides the quality threshold value for segment alignment and low
      quality sequences correction algorithms

  lq:
    type: ["null", string]
    inputBinding:
      prefix: -lq
    doc: overrides low quality CDR3s processing strategy

  pcrec:
    type: ["null", string]
    inputBinding:
      prefix: -pcrec
    doc: overrides the PCR and high quality sequencing errors correction 
      algorithm

  limit:
    type: ["null", string]
    inputBinding:
      prefix: -limit
    doc: limits the number of input sequencing reads, use this parameter to
      normalize several datasets or to have a glance at the data

  report:
    type: ["null", string]
    inputBinding:
      prefix: -report
    doc: turns on the reporting and sets the name of report file. Report
      contains information on bulk characteristics of dataset, resulting clone
      set and analysis process

  level:
    type: ["null", int]
    inputBinding:
      prefix: -level
    doc: verbosity level for tab­ delimited output (see “output formats” 
      section for details). Has no effect if cls is used as output format

outputs:

  output_file:
    type: File
    outputBinding:
      glob: $(inputs.output_string)
    doc: see output_string

  report_file:
    type: ["null", File]
    outputBinding:
      glob: $(inputs.report)
    doc: only produced when report option is used


  


