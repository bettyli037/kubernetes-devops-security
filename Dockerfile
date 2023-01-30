FROM maven:3.8.6-jdk-11 AS build
EXPOSE 8080
COPY . ./
RUN mvn clean package -DskipTests=true
RUN mvn org.pitest:pitest-maven:mutationCoverage
ENTRYPOINT ["java","-jar","/app.jar"]

#Try another way for the report.