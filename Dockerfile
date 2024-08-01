FROM eclipse-temurin:21-jdk-alpine
VOLUME /app
ARG JAR_FILE="al-falah-banking-service-0.0.1-SNAPSHOT.jar"
COPY src/main/resources/application.properties application-dev.properties
ENTRYPOINT ["java", "-jar","-Dspring.profiles.active=dev","/app.jar"]