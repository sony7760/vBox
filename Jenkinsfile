pipeline {
  agent any
  parameters {
        string(name: 'environment', defaultValue: 'tfenv', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'destroy', description: 'Destroy your infrastructure?')
        booleanParam(name: 'apply', description: 'This will apply your chnages!') 
    }
  environment {
    TF_LOG = 'DEBUG'
    PATH = "/usr/local/bin:${env.PATH}"
  }
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
      when {
                expression {
                    params.apply == true
                }
            }
      steps {
        sh "terraform apply vbox.out"
      }
    }
    stage('destroy') {
      when {
                expression {
                    params.destroy == true
                }
            }
      steps {
        sh "terraform destroy --auto-approve"
      }
    }
  } /* ## close for stages*/
}  /* ## close for Pipeline*/
