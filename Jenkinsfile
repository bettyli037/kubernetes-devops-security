pipeline {
  agent {
    label 'translator && aws && build && poc'
 } 
  stages {
    stage('Build Artifact') {
      steps {
        sh "mvn clean package -DskipTests=true"
          archive 'target/*.jar' //so that they can be downloaded later
      }
    }   
    stage('Unit Tests - JUnit and Jacoco') {
      steps {
        sh "mvn test"
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
          jacoco execPattern: 'target/jacoco.exec'
        }
      }
    }
    stage('SonarQube - SAST') {
      steps {
        sh "mvn clean verify sonar:sonar \
            -Dsonar.projectKey=numeric-application \
            -Dsonar.host.url=http://sonarqube-bl-1456515170.us-east-1.elb.amazonaws.com \
            -Dsonar.login=sqp_4f740a0a03b4916fcdb1e8b115fa843ed229832c"
      }
    } 
  }
}
