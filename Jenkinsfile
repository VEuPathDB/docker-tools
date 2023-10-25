#!groovy

@Library('pipelib')
import org.veupathdb.lib.Builder

node('centos8') {
  def builder = new Builder(this)

  checkout scm
  builder.buildContainers([
    [ name: 'shortreadaligner', dockerfile: "shortreadaligner/Dockerfile", path: "shortreadaligner" ],
    [ name: 'vcf_parser_cnv', dockerfile: "vcf_parser_cnv/Dockerfile", path: "vcf_parser_cnv" ],
    [ name: 'craig', dockerfile: "craig/Dockerfile", path: "craig" ],
    [ name: 'edirect', dockerfile: "edirect/Dockerfile", path: "edirect" ],
  ])
}
