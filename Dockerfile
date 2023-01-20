FROM maven:3.8.6-jdk-11 AS build
EXPOSE 8080
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} app.jar
RUN mvn clean package -DskipTests=true
ENTRYPOINT ["java","-jar","/app.jar"]