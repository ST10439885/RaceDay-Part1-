
# Use the .NET 8 runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app

ENV ASPNETCORE_HTTP_PORTS=8080

EXPOSE 8080

# Build the MVC application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY ["RaceDay.MVC.csproj", "./"]

RUN dotnet restore "RaceDay.MVC.csproj"

COPY . .

RUN dotnet publish "RaceDay.MVC.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Create the final Docker image
FROM base AS final

WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "RaceDay.MVC.dll"]
