# Use an official Java runtime as a parent image
FROM openjdk:8-jdk

# Install SBT
RUN apt-get update && \
    apt-get install -y curl && \
    curl -L -o sbt.deb https://scala.jfrog.io/artifactory/debian/sbt-0.13.18.deb && \
    dpkg -i sbt.deb && \
    apt-get update && \
    apt-get install sbt && \
    rm sbt.deb

# Set the working directory
WORKDIR /app

# Copy only the build.sbt and project files first
COPY build.sbt .
COPY project/ project/

# Run SBT commands to download dependencies and compile before copying the entire project
# RUN sbt update

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 9000

# Run the app
CMD ["sbt", "clean", "compile", "run"]
# CMD ["sbt", "run"]
