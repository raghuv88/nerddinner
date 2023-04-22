#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app
RUN echo path
COPY $(Build.Repository.LocalPath)/NerdDinner.sln .
COPY DockerSample/*.csproj ./DockerSample/
COPY DockerSample/*.config ./DockerSample/
RUN nuget restore
COPY DockerSample/. ./DockerSample/
RUN msbuild /p:Configuration=Release -r:False

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
ARG source
WORKDIR /inetpub/wwwroot
COPY ${source:-obj/Docker/publish} .
