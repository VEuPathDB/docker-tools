#!groovy

@Library('pipelib')
import org.veupathdb.lib.Builder

node('centos8') {
  def builder = new Builder(this)

  builder.gitClone()
  builder.buildContainers([
    [ name: 'shortreadaligner', dockerfile: "shortreadaligner/Dockerfile", path: "shortreadaligner" ],
    [ name: 'vcf_parser_cnv', dockerfile: "vcf_parser_cnv/Dockerfile", path: "vcf_parser_cnv" ],
    [ name: 'edirect', dockerfile: "edirect/Dockerfile", path: "edirect" ],
    [ name: 'alpine_bash', dockerfile: "alpine_bash/Dockerfile", path: "alpine_bash" ],
    [ name: 'bioperl', dockerfile: "bioperl/Dockerfile", path: "bioperl" ],
    [ name: 'gusenv', dockerfile: "gusenv/Dockerfile", path: "gusenv" ],
  ])
}
