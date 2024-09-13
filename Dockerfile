# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-11-slim AS build

# Set working directory
WORKDIR /app

# Copy the pom.xml and modules to the container
COPY pom.xml ./
COPY onion-arch-service-api/pom.xml ./onion-arch-service-api/
COPY onion-arch-service-core/pom.xml ./onion-arch-service-core/
COPY onion-arch-service-infra-api-rest/pom.xml ./onion-arch-service-infra-api-rest/
COPY onion-arch-service-infra-jpa/pom.xml ./onion-arch-service-infra-jpa/
COPY onion-arch-service/pom.xml ./onion-arch-service/

# Copy the actual source code of the modules
COPY onion-arch-service-api ./onion-arch-service-api
COPY onion-arch-service-core ./onion-arch-service-core
COPY onion-arch-service-infra-api-rest ./onion-arch-service-infra-api-rest
COPY onion-arch-service-infra-jpa ./onion-arch-service-infra-jpa
COPY onion-arch-service ./onion-arch-service

# Build the project using Maven
RUN mvn clean install -DskipTests

# Stage 2: Create the final image with JDK 11 to run the app
FROM openjdk:11-jdk-slim

# Set environment variables
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the previous build stage
COPY --from=build /app/onion-arch-service/target/onion-arch-service.jar onionarchitecture.jar

# Expose port 8088
EXPOSE 8088

# Command to run the application
ENTRYPOINT exec java $JAVA_OPTS -jar onionarchitecture.jar