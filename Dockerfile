# Use OpenJDK as the base image
FROM openjdk:11-jre-slim

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from Maven target folder to the container
COPY target/my-java-app-1.0-SNAPSHOT.jar app.jar

# Expose the port (Optional if needed)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]

