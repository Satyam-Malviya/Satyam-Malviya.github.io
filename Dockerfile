# Stage 1: Compile and Build Angular Codebase
FROM node:alpine as build

RUN mkdir -p /app
WORKDIR /app
COPY package.json /app

RUN npm install --force

COPY . /app
RUN npm run build

# Stage 2: Serve app with Nginx
FROM nginx:alpine

# Ensure we use the correct build output directory
COPY --from=build /app/dist /usr/share/nginx/html

LABEL org.opencontainers.image.source https://github.com/Satyam-Malviya/Satyam-Malviya.github.io

EXPOSE 80
