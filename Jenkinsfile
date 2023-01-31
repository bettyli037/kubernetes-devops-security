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
    // stage('Mutation Tests - PIT') {
    //   steps {
    //     sh "mvn org.pitest:pitest-maven:mutationCoverage"
    //   }
    //   post {
    //     always {
    //       pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
    //     }
    //   }
    // }
    stage('SonarQube - SAST') {
      steps {
        sh "mvn clean verify sonar:sonar \
            -Dsonar.projectKey=numeric-application \
            -Dsonar.host.url=http://localhost:9000 \
            -Dsonar.login=sqp_feade5c7502e43abfa909a73cd7fd179d816aa83"
      }
    } 
  }
}
