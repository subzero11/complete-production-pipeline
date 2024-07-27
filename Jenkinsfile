pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk "Java17"
        maven "Maven3"
    }
    stages{
        stage("Cleanup WorkSpace"){
            steps{
                cleanWs()
            }
        }
    }
    stages{
        stage("Checkout from SCM"){
            steps{
                git branch: 'main', credentials: 'github', url: 'https://github.com/subzero11/complete-production-pipeline'
            }
        }
    }
}
