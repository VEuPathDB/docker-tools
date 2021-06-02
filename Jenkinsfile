#!groovy

@Library('pipelib')
import org.veupathdb.lib.Builder

node('centos8') {
  def builder = new Builder(this)

  checkout scm
  builder.buildContainers([
    [ name: 'shortreadaligner', dockerfile: "shortreadaligner/Dockerfile", path: "shortreadaligner" ],
    [ name: 'vcfParserCNV', dockerfile: "vcfParserCNV/Dockerfile", path: "vcfParserCNV" ],
  ])
}
