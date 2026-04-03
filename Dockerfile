# Use a base OpenJDK image
FROM eclipse-temurin:17-jdk

# Copy the built jar into the image
COPY target/mywebapp-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the app runs on
EXPOSE 8081

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app.jar"]
