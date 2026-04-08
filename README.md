# ms-dacs2025-backend

Microservice for operating room schedule management. Allows you to manage the scheduling, availability, and reservations of operating rooms, facilitating the organization of surgeries and the efficient management of hospital resources. Uses a Postgres database to store information.

## Objective
![Alternative text](assets/infraestructura.png)

## Configuration
[See the infrastructure configuration (PDF)](assets/DACS-configuracion-de-infraestructura.pdf)

# Backend

This is the **Backend** project for DACS2025.

## Description
A Spring Boot application that provides the core business logic and API endpoints for the DACS2025 system.

## Features
- RESTful API
- Database integration (PostgreSQL)
- Logging and monitoring
- NGINX configuration for reverse proxy

## Requirements
- Java 17+
- Maven 3.6+
- PostgreSQL


## Architecture & Technology Stack

**Patterns:**
- RESTful API design
- Layered architecture (Controller, Service, Repository)
- Dependency Injection (Spring Framework)
- Configuration via YAML/properties

**Technology Stack:**
- Java 17+
- Spring Boot
- Maven
- PostgreSQL
- NGINX (reverse proxy)


## Getting Started
1. Clone the repository.
2. Configure your database settings in `src/main/resources/application.yml` or `application.properties`.
3. Build the project:
	```bash
	./mvnw clean install
	```
4. Run the application:
	```bash
	./mvnw spring-boot:run
	```

## Project Structure
- `src/main/java` - Source code
- `src/main/resources` - Configuration files
- `db/postgres` - Database scripts
- `nginx` - NGINX configuration

## Learning & Experience

This backend project has provided valuable experience in designing and implementing microservices using Spring Boot. Key learning outcomes include:

- Applying best practices for RESTful API development and layered architecture.
- Integrating with PostgreSQL and managing database migrations.
- Implementing security, logging, and monitoring in a production-ready environment.
- Working with NGINX as a reverse proxy for improved scalability and security.
- Collaborating in a distributed team and using Git for version control.

These experiences have contributed to a deeper understanding of enterprise backend development and cloud-ready architectures.



