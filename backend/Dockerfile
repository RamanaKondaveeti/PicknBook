# ---------- Stage 1: Build ----------
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /src

# Copy only csproj first (better caching)
COPY ["PickNBook.Api.csproj", "./"]

# Restore dependencies
RUN dotnet restore "PickNBook.Api.csproj"

# Copy everything else
COPY . .

# Publish (optimized)
RUN dotnet publish "PickNBook.Api.csproj" \
    -c Release \
    -o /app/publish \
    /p:UseAppHost=false \
    /p:SelfContained=false \
    /p:PublishTrimmed=false    

# ---------- Stage 2: Runtime ----------
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS runtime
WORKDIR /app

# Environment settings
ENV ASPNETCORE_URLS=http://+:5007
ENV ASPNETCORE_ENVIRONMENT=Production
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

# Copy published app
COPY --from=build /app/publish .

# Expose port
EXPOSE 5007

# Health check (optional but good)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5007/health || exit 1

ENTRYPOINT ["dotnet", "PickNBook.Api.dll"]