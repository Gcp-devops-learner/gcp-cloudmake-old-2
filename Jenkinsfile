def terrafromImageVersion = '1.3.8'
def tflintImageVersion = 'v0.45.0.0'
def checkovImageVersion = '2.3.3'

def changedFiles = []
def changedFolders = []

pipeline {
    agent { label 'docker-cloud-small'}
    stages {
        stage('Set variables') {
            steps{
                script {
                    changedFiles = sh (
                        script: 'git diff --diff-filter=d --name-only origin/master... | grep \'.*/.*\\.tf.*$\' || true',
                        returnStdout: true
                    ).trim().split('\n').findAll()

                    if ( changedFiles.size() > 0 ){
                        changedFolders = sh (
                            script: 'git diff --diff-filter=d --name-only origin/master...| grep \'.*/.*\\.tf.*$\' | xargs dirname | sort | uniq',
                            returnStdout: true
                        ).trim().split('\n').findAll()
                    }
                }
            }
        }
        stage('Run Tests') {
            parallel {
                stage('Check terraform proper format') {
                    agent {
                        docker { 
                            image "hashicorp/terraform:${terrafromImageVersion}"
                            reuseNode true
                            args "--entrypoint=''"
                        }
                    }
                    steps {            
                        script{
                            changedFiles.each {
                                sh "terraform fmt -check -diff ${it}"
                            }
                        }
                    }
                }
                stage('Lint terrafrom code') {
                    agent {
                        docker {
                            image "ghcr.io/terraform-linters/tflint-bundle:${tflintImageVersion}"
                            reuseNode true
                            args "-u root --entrypoint=''"
                        }
                    }
                    steps {
                        script {
                            changedFolders.each {
                                sh "tflint -c .tflint.hcl ${it}"
                            }
                        }
                    }
                }
                stage('Do checkov checks') {
                    agent {
                        docker { 
                            image "bridgecrew/checkov:${checkovImageVersion}"
                            reuseNode true
                            args "--entrypoint=''"
                        }
                    }
                    steps {
                        script {
                            changedFolders.each {
                                sh "checkov --config-file .checkov.yaml --soft-fail --quiet -o junitxml --output-file-path . --directory ${it}"
                                junit (
                                    testResults: 'results_junitxml.xml',
                                    allowEmptyResults : true
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}
