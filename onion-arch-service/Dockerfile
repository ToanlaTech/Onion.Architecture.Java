FROM openjdk:11-jdk-slim
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY target/onion-arch-service.jar onionarchitecture.jar
EXPOSE 8081
ENTRYPOINT exec java $JAVA_OPTS -jar onionarchitecture.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar onionarchitecture.jar
