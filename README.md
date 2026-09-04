# 🏃 RaceDay – Event Management System

## 📌 Project Overview

RaceDay is a full-stack web-based event management system designed for the South African road running, walking and cycling community.

The system allows event organisers to create and manage sporting events, categories, participant enrolments and race results. Participants can browse upcoming events, register for events, select categories and view their personal race history.

The project is developed progressively using:

* C#
* ASP.NET Core Web API
* ASP.NET Core MVC
* Entity Framework Core
* SQL Server
* Swagger
* GitHub Actions CI/CD
* Azure Blob Storage
* Docker

---

## 👥 User Roles

### 🏆 Organiser

Organisers can:

* Create, edit and delete events
* Manage event categories
* View participant enrolments
* Capture participant results
* View event information
* Upload event banner images

### 🏃 Participant

Participants can:

* Create an account
* Log in to the system
* Browse upcoming events
* View event details and categories
* Enter events
* View their enrolments
* Track their race results
* Update their profile
* Upload a profile picture

Role-based access is enforced so that users can only access functionality appropriate to their role.

---

# 📁 Project Structure

```text
RaceDay/
│
├── docs/
│   ├── ERD.png
│   ├── API-Endpoint-Plan.md
│   └── RaceDay.sql
│
├── RaceDay.API/
│   └── ASP.NET Core Web API
│
├── RaceDay.Tests/
│   └── Unit Tests
│
├── RaceDay.MVC/
│   └── ASP.NET Core MVC Application
│
├── .github/
│   └── workflows/
│       └── dotnet.yml
│
├── Dockerfile
└── README.md
```

---

# 🗄️ Database

The RaceDay system uses SQL Server as its database.

The database contains the entities required to manage:

* Users
* Events
* Categories
* Event Enrolments
* Results

The database design is documented in the ERD located in the `/docs` folder.

The SQL script used to create and populate the database is also located in `/docs`.

---

# 🔌 API

The RaceDay API is developed using ASP.NET Core Web API.

The API provides functionality for:

* Authentication
* User profiles
* Events
* Categories
* Event enrolments
* Results

Swagger is integrated into the API so that endpoints can be viewed and tested through the browser.

### Running the API

1. Open the solution in Visual Studio.
2. Configure the SQL Server connection string.
3. Restore NuGet packages.
4. Build the solution.
5. Run the API.
6. Open Swagger in the browser.

---

# 🔐 Authentication

The system supports registration and login for both Organisers and Participants.

Passwords are securely hashed before being stored.

Session management is used to maintain the authenticated user's identity and role.

Protected API functionality requires authentication, while role-specific functionality is restricted according to the user's role.

---

# 🧪 Unit Testing

Unit tests are included to verify that the API behaves correctly.

Tests cover areas including:

* User registration
* User login
* Organiser event management
* Role-based access
* Participant event enrolment
* Expected successful requests
* Expected failed requests

The tests are also executed through the GitHub Actions CI/CD workflow.

---

# ⚙️ CI/CD

GitHub Actions is used to automatically build and test the project.

The workflow runs when changes are pushed to the repository.

A successful workflow is represented by a green check mark.

### CI/CD Screenshot

Add your screenshot below:

```text
[INSERT YOUR GREEN GITHUB ACTIONS SCREENSHOT HERE]
```

---

# ☁️ Azure Blob Storage

Azure Blob Storage is used for storing uploaded images.

The API handles communication with Azure Blob Storage.

Images supported include:

* Event banner images
* Participant profile pictures

The stored image URL can then be used by the MVC application to display the image.

---

# 🖥️ MVC Web Application

The MVC application provides the user interface for RaceDay.

The MVC application communicates with the REST API for data operations and does not directly access the database.

The application provides different navigation and functionality for Organisers and Participants.

---

# 🐳 Docker

The MVC application is containerised using Docker.

### Build the Docker image

```bash
docker build -t raceday .
```

### Run the container

```bash
docker run -p 8080:8080 raceday
```

The application can then be accessed through the configured local address.

---

# ▶️ How to Run the Project

### Requirements

Before running the project, install:

* Visual Studio
* .NET SDK
* SQL Server / SQL Server Management Studio
* Docker Desktop
* Git

### Steps

1. Clone the repository.
2. Open the solution in Visual Studio.
3. Configure the database connection.
4. Create the RaceDay database using the SQL script in `/docs`.
5. Restore the required NuGet packages.
6. Build the solution.
7. Run the API.
8. Run the MVC application.
9. Test the API through Swagger.
10. Test the MVC application through the browser.

---

# 🎥 Video Presentation

An unlisted YouTube video demonstrating the project is provided below.

**YouTube Video:**
`[PASTE YOUR UNLISTED YOUTUBE LINK HERE]`

The video demonstrates the application, explains the project structure and shows the implemented functionality.

---

# 📚 Documentation

The `/docs` folder contains the planning documentation for the RaceDay system:

* Entity Relationship Diagram (ERD)
* API Endpoint Plan
* SQL Database Script

---

# 👨‍💻 Author

**Student Name:** Vhugala Thobakgale

**Student Number:** ST10439885

**Module:** Programming 2B

**Module Code:** PROG6212

---

# ⚠️ AI Usage Disclosure

AI tools were used during the development process for assistance with planning, troubleshooting, explanations and/or proofreading. The final implementation was reviewed and understood by the student.
