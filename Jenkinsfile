pipeline{
    agent{
        label "jenkins-agent"
    }
    tools{
        jdk 'Java17'
        maven 'Maven3'
    }
    environment{
	    APP_NAME = "complete-production-pipeline"
	    RELEASE = "1.0.0"
	    DOCKER_USER = "newguyinli"
	    DOCKER_PASS = "dockerhub"
	    IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
	    IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	    APP_NAME = "complete-production-pipeline"
	    JENKINS_API_TOKEN = "JENKINS_API_TOKEN"
    }
    stages{
        stage('Clean Workspace'){
            steps{
                cleanWs()
            }
            }
        stage('Checkout from SCM'){
            steps{
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/subzero11/complete-production-pipeline'
            }
        }
        stage('Build Application'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Test Application'){
            steps{
                sh "mvn test"
            }
        }
         stage('Sonarqube Analysis'){
            steps{
		script{
		    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token'){
                	sh "mvn sonar:sonar"
				}
        		}
		}
        }
         stage('Quality Gate'){
            steps{
		script{
		    waitForQualityGate abortPipeLine: false, credentialsId: 'jenkins-sonarqube-token'
        		}
		}
        }
	  stage('Build and Push Docker Image'){
            steps{
		script{
		    docker.withRegistry('', DOCKER_PASS){
			    docker_image = docker.build "${IMAGE_NAME}"
		    }
		    docker.withRegistry('', DOCKER_PASS){
			docker_image.push("${IMAGE_TAG}")
			docker_image.push('latest')
		    }
        		}
		}
        }   

	  stage('Trigger CD Pipeline'){
            steps{
		script{
		    sh "curl -v -k --user admin:${JENKINS_API_TOKEN}" -X POST -H "cache-control: no-cache" "content-type: application/x-www-form-urlencoded" --data "IMAGE_TAG=${IMAGE_TAG}" 'https://tariqkhan.liquidsphere.com/job/gitops-complete-pipeline/buildWithParameters?token=gitops-token'
        		}
		}
        }   
	    
    }
}
