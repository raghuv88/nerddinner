#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app
COPY ["*.sln" "./"]
COPY src/*.csproj ./src/
COPY src/*.config ./src/
RUN nuget restore
COPY src/. ./src/
RUN msbuild /p:Configuration=Release -r:False

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
ARG source
WORKDIR /inetpub/wwwroot
COPY --from=build /app/src/. ./
#COPY ${source:-obj/Docker/publish} .
