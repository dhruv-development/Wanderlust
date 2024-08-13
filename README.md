<h2> Docker_Projects </h2>
This repository contains three Dockerized projects that demonstrate the use of Docker for containerizing applications in different programming languages.
<br>
<b>Java Project: Hello and Date Printer </b>
Description: This project is a simple Java application that prints "Hello" and the current date to the console.
Purpose: It demonstrates how to containerize a basic Java application using Docker, providing an example of how to package and deploy Java applications consistently across different environments.
Dockerfile: The Dockerfile is configured to compile and run the Java application within a Docker container.
<br>
<b> Python Flask Project </b>
Description: This project is a web application built using the Python Flask framework. The application includes an API endpoint that returns a message indicating the server is up and running. Additionally, it features an aesthetically pleasing homepage with a navbar and well-styled content.
Purpose: It serves as an example of how to containerize a Python Flask web application using Docker, showcasing best practices for deploying web applications in a containerized environment.
Dockerfile: The Dockerfile is set up to install necessary dependencies, set environment variables, and run the Flask application within a Docker container.
<br>
<b> Two-Tier Application Project </b>
Description: This project is a two-tier web application that combines a Python Flask-based web server and a MySQL database. The Flask application serves as the front-end, handling user requests, while the MySQL database serves as the back-end, managing data storage.
Purpose: It demonstrates how to design, build, and deploy a multi-container setup using Docker. The project showcases the separation of the front-end and back-end, emphasizing modularity and scalability in a containerized environment.
Docker Setup: The Docker setup includes a Docker Compose file that orchestrates the deployment of both containers. The Flask web server handles HTTP requests, and the MySQL database manages data persistence. The setup demonstrates how to manage inter-container communication and environment variables using Docker Compose.
