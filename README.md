# RaceDay Management System

## 1. Project Description

RaceDay is a web-based race event management system developed as part of the PROG6212 Portfolio of Evidence (POE).

The system allows race organisers to create and manage events, categories, participant enrolments and race results. Participants can register, log in, browse upcoming events, enrol in races, manage their profiles and view their results.

The solution consists of an ASP.NET Core Web API and an ASP.NET Core MVC application.

## 2. User Roles

The system supports two user roles:

- **Organiser:** Creates and manages race events, manages categories, views participant enrolments and records race results.
- **Participant:** Registers and logs in, browses events, enrols in events, manages personal profile information and views results.

## 3. Main Features

- User registration and login.
- Password hashing and JWT authentication.
- Role-based access control.
- Create, view, update and delete race events.
- Search and filter upcoming events.
- Create and manage event categories.
- Participant event enrolments and cancellations.
- Organiser registration management.
- Capture and update race results.
- Participant profile viewing and updating.
- Organiser and participant dashboards.
- REST API integration between MVC and API.
- Responsive Bootstrap user interface.
- Docker support for the MVC application.

## 4. Technologies Used

- C#
- ASP.NET Core Web API
- ASP.NET Core MVC
- .NET 8
- Entity Framework Core
- Microsoft SQL Server
- JWT Authentication
- HTML and CSS
- Bootstrap
- Swagger / OpenAPI
- Docker
- Git and GitHub
- GitHub Actions

## 5. Project Structure

- `RaceDay.API/` – REST API and backend functionality.
- `RaceDay.MVC/` – MVC user interface.
- `README.md` – Project documentation.
- `.github/workflows/` – GitHub Actions workflow files.
- `RaceDay_ERD.png` – Database entity relationship diagram.
- `SQL Part one.sql` – Database SQL script.
- `API_Endpoint_Plan (1).pdf` – API endpoint planning document.

## 6. Database Setup

The system uses Microsoft SQL Server.

1. Install SQL Server and SQL Server Management Studio.
2. Ensure the SQL Server instance is running.
3. Execute the supplied SQL script if the database has not already been created.
4. Configure the database connection string in the API's `appsettings.json`.
5. Ensure that the database name and SQL Server instance match your local environment.

Do not publish database passwords, private credentials or production JWT secrets.

## 7. Running the Application Locally

1. Open the RaceDay solution in Visual Studio 2022.
2. Restore the NuGet packages.
3. Configure the API database connection string.
4. Start the `RaceDay.API` project.
5. Confirm that the API is running.
6. Start the `RaceDay.MVC` project.
7. Open the MVC application in your browser.

The API Swagger interface can be accessed using the configured Swagger URL.

## 8. Docker Instructions

Docker Desktop must be installed and running.

The Dockerfile is located inside the `RaceDay.MVC` project folder.

Open a terminal in the `RaceDay.MVC` directory.

### Build the Docker image

```bash
docker build -t raceday-mvc .
```

### Run the container

Start the API separately and ensure it is accessible on port 5089.

```bash
docker run -d -p 8080:8080 --name raceday-mvc-container -e ApiSettings__BaseUrl=http://host.docker.internal:5089/ raceday-mvc
```

### Access the application

Open the following address in your browser:

`http://localhost:8080`

The MVC container communicates with the API running on the host machine.

For local Docker testing, the API must be configured to accept the HTTP connection. Production deployments should use properly configured HTTPS.

### Stop the container

```bash
docker stop raceday-mvc-container
```

### Remove the container

```bash
docker rm raceday-mvc-container
```

## 9. API and MVC Communication

The MVC application uses HTTP requests to communicate with the RaceDay REST API.

Protected API requests use the JWT token stored in the user's session. The API handles the backend operations and database communication.

The MVC application does not directly access the SQL Server database.

## 10. Testing and CI/CD

The application was tested through registration, login, role-based navigation, event management, category management, participant enrolments, results and profile updates.

The MVC Docker image was successfully built and tested, including participant login through the running container.

The GitHub Actions workflow is included in the repository for automated build validation. Its final status should be checked under the GitHub Actions tab.

## 11. Project Limitations and Future Improvements

Further improvements include:

- Azure Blob Storage integration for event banner uploads.
- Participant profile picture uploads.
- Additional automated unit and integration tests.
- Further deployment and production security configuration.

## 12. AI Use Disclosure

AI assistance was used during development to help understand programming concepts, troubleshoot errors, review code and improve project documentation. The application was built, configured and tested by the student.

## 13. Repository

GitHub Repository:

https://github.com/ST10439885/RaceDay-Part1-

