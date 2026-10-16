# RaceDay Management System

## 1. Project Description

RaceDay is a web-based event management system designed to help organisers manage race events and allow participants to register, enrol in events, and view their results. The system uses an ASP.NET Core Web API, C#, Entity Framework Core, and Microsoft SQL Server.

## 2. User Roles

The system supports two user roles:

- **Organiser:** Can create and manage events, manage event categories, view enrolments, and record or update race results.
- **Participant:** Can register and log in, view events, manage their own profile, enrol in events, cancel enrolments, and view their results.

## 3. Main Features

- User registration and login using password hashing and JWT authentication.
- Role-based access control for organisers and participants.
- Create, view, update, and manage race event information.
- Manage event categories.
- Enrol participants in race events.
- View enrolment information and race results.
- View and update personal profile information.
- SQL Server database integration using Entity Framework Core.
- Swagger UI for testing API endpoints.
- GitHub Actions for automated build and test validation.

## 4. Technologies Used

- C#
- ASP.NET Core Web API
- .NET 8
- Entity Framework Core
- Microsoft SQL Server
- JWT Authentication
- Swagger / OpenAPI
- Git and GitHub
- GitHub Actions

## 5. Project Structure

- `Controllers/` — API endpoints and request handling.
- `Models/` — Data models used by the application.
- `Data/` — Database context and Entity Framework configuration.
- `appsettings.json` — Application configuration and database connection settings.
- `Program.cs` — Application setup, dependency injection, authentication, and middleware.
- `docs/` — Project documentation, ERD, API endpoint plan, and SQL script.
- `.github/workflows/` — GitHub Actions workflow files.

## 6. Database Setup

The application uses Microsoft SQL Server and Entity Framework Core.

1. Install SQL Server and ensure the SQL Server instance is running.
2. Execute the supplied SQL script in SQL Server Management Studio if required by the project setup.
3. Configure the `RaceDayConnection` connection string in `appsettings.json` to match your local SQL Server instance.
4. Ensure the database and required tables exist before running the API.

Do not publish production passwords, database credentials, or secret JWT keys in the repository.

## 7. Running the Application

1. Open the RaceDay solution in Visual Studio.
2. Restore the required NuGet packages.
3. Check the database connection string.
4. Build the solution.
5. Run the application.
6. Open the Swagger URL shown in the browser to explore and test the API endpoints.

## 8. API Documentation

The API endpoint plan and Entity Relationship Diagram (ERD) are provided in the `docs/` directory. Swagger provides an interactive interface for testing available endpoints.

## 9. Testing and CI/CD

The project uses GitHub for version control. The GitHub Actions workflow is intended to validate the project by restoring dependencies, building the application, and running automated tests where configured.

## 10. Project Status

The RaceDay API is being developed as part of the PROG6212 Portfolio of Evidence (POE). Features and automated tests should be verified against the final submission requirements before delivery.
