# ======================== # 
# == Worker Docker File == # 
# ======================== # 
# Stage 1: Building Stage 
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

WORKDIR /app

COPY Worker.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/publish --no-restore

# Stage 2: Production Stage 
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS serve

WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 5252

ENTRYPOINT [ "dotnet", "Worker.dll" ]

