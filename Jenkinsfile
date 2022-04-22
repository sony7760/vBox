pipeline {
  agent any
  stages {
    stage('test') {
      steps {
        sh 'echo "Hello, vBox"'
      }
    }
    stage('init') {
      steps {
        sh "terraform init -force-copy"
      }
    }
  } /* ## close for stages*/
}  /* ## close for Pipeline*/
