# Project Documentation

This document provides a step-by-step guide to set up and run the project locally.

## Prerequisites

Ensure you have the following software installed on your system before proceeding:

1. **JDK 17** 
2. **Apache Maven (3.x)**  
3. **MySQL Server & Workbench**   
   - Set up a local MySQL database connection.

## Steps to Run the Application
### 1. Clone the Repository
Clone the project from GitHub using the following command:  
```bash
git clone <repository-url>
open this project in ide like intellij idea

### 2. build the application using
       mvn clean install, in the terminal 

### 3. update the application.properties file
      update below two properties
      spring.datasource.url=jdbc:mysql://localhost:3306/your_database_name
      spring.datasource.username= your_dbusername
      spring.datasource.password= your_dbpassword

### 4. run the application using this command in the intellij terminal
       mvn spring-boot:run
### 5. access the application using below uri to see the user interface
       http://localhost:8081/employees
       
     


