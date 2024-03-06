pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
        stage('Checkout from SCM'){
            steps{
                git branch 'main', credentialsId: 'github', url: 'https://github.com/subzero11/complete-production-pipeline'
            }
        }
        }
    }
}
