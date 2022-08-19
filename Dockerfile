# Stage 1 "build stage", this is used for building the front end
FROM ubuntu:20.04 as build-stage

ARG BASE_URL="https://localhost:6969/api/v1/"

# Specifiy some Flutter environment paths
ENV PATH=/opt/flutter/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/flutter/.pub-cache/bin

# Install/update Ubuntu essentials required to install Flutter
RUN apt-get update
RUN apt-get install -y \
        xz-utils \
        git \
        openssh-client \
        curl && \
    apt-get upgrade -y && \
    rm -rf /var/cache/apt

# Download and install Flutter + essential tools
RUN curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.1-stable.tar.xz | tar -C /opt -xJ
RUN apt-get update
RUN apt-get install -y lib32stdc++6
RUN apt-get install unzip

# Set the working directory
WORKDIR /app

# Copy over the Flutter project
COPY ./ ./

# Do some fun Flutter things
RUN git config --global --add safe.directory /opt/flutter
RUN flutter doctor
RUN flutter pub get

# Build the Flutter app as a Web App
RUN flutter build web --dart-define=BASE_URL=$BASE_URL

# The below build command actually runs smoother, but has issues
# RUN flutter build web --release --web-renderer html --dart-define=BASE_URL=$BASE_URL

# Stage 2 Nginx
# This is a Nginx docker image with Brotli/ModSecurity/OWASP ModSecurity Core Rule Set (CRS)
# See: https://hub.docker.com/r/krish512/modsecurity/
FROM krish512/modsecurity

WORKDIR /root/

ARG CERTIFICATEFILE="localhost.crt"
ARG CERTIFICATEKEY="localhost.key"
ARG NGINXCONF="nginx.conf"

# Expose ports for Flutter
EXPOSE 6868

# Copy the ES5 bundle from the build stage to Nginx
COPY --from=build-stage /app/build/web /usr/share/nginx/html

# Copy the nginx configuration file
COPY --from=build-stage /app/$NGINXCONF /etc/nginx/conf.d/default.conf

# Copy the SSL Certificate
COPY --from=build-stage /app/$CERTIFICATEFILE /etc/nginx/ssl/$CERTIFICATEFILE

# Copy the SSL Key
COPY --from=build-stage /app/$CERTIFICATEKEY /etc/nginx/ssl/$CERTIFICATEKEY

# Copy the Diffie-Hellman certificate (for TLS)
COPY --from=build-stage /app/dhparams.pem /etc/nginx/ssl/dhparams.pem