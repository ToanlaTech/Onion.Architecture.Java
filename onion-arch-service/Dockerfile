# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Stage 2: Create the final image with JDK 11 to run the app
FROM openjdk:11-jdk-slim
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
WORKDIR /app
COPY --from=build /app/target/onion-arch-service.jar onionarchitecture.jar
EXPOSE 8088
ENTRYPOINT exec java $JAVA_OPTS -jar onionarchitecture.jar
