FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /App
COPY .gdbinit .
COPY run.sh .
COPY --from=build /App/out .
RUN apt-get update && apt-get install gdb -y && mkdir -p ~/.config/gdb/ && cp .gdbinit ~/.config/gdb/gdbinit
#ENTRYPOINT ["gdb ./GMS-CSharp-Server"]
ENTRYPOINT ["./run.sh"]
