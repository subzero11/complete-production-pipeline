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

        stage("Checkout from SCM"){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/subzero11/complete-production-pipeline'
            }
        }
    
        stage("Build Application"){
            steps{
                sh "mvn clean package"
            }
        }

        stage("Test Application"){
            steps{
                sh "mvn test"
            }
        }

        stage("SonarQube Analysis"){
            steps{
                script{
                withSonarQubeEnv(installationName: 'MySonarQube', credentialsId: 'jenkins-sonarqube-token'){
                    sh "mvn sonar:sonar"
                }
                }
            }
        }
    }
}
