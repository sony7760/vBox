pipeline {
  agent any
  environment {
    TF_LOG = 'DEBUG'
  }
  stages {
    stage('test') {
      steps {
        sh 'echo "Hello, vBox"'
        sh 'echo $PATH'
      }
    }
    stage('init') {
      steps {
        sh "/usr/local/bin/terraform init -force-copy"
      }
    }
    stage('validate') {
      steps {
        sh "terraform validate"
      }
    }
    stage('plan') {
      steps {
        sh "terraform plan -out vbox.out"
      }
    }
    stage('apply') {
      steps {
        sh "terraform apply vbox.out"
      }
    }
  } /* ## close for stages*/
}  /* ## close for Pipeline*/
