FROM maven:3.9.9-eclipse-temurin-8-alpine AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM tomcat:9.0.95-jre8-temurin-jammy

RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the generated WAR file to tomcat
COPY --from=build /app/target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Tomcat default port)
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
