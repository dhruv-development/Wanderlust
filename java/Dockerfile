#base image 
FROM openjdk:17-jdk-alpine

#working directory
WORKDIR /app

#copy code into source
COPY src/Main.java /app/Main.java

#compile code
RUN javac Main.java

#Run
CMD ["java","Main"]
