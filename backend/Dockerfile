FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["PickNBook.Api.csproj", "./"]
RUN dotnet restore "PickNBook.Api.csproj"

COPY . .
RUN dotnet publish "PickNBook.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:5007
ENV ASPNETCORE_ENVIRONMENT=Production

COPY --from=build /app/publish .

EXPOSE 5007

ENTRYPOINT ["dotnet", "PickNBook.Api.dll"]
