FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["DockerReview.csproj", "."]
RUN dotnet restore "DockerReview.csproj"
COPY . .
RUN dotnet publish "DockerReview.csproj" -c Release -o /publish

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS final
WORKDIR /app
COPY --from=build /publish .

ENTRYPOINT ["dotnet", "DockerReview.dll"]
