# Stage 1: Compile and Build Angular codebase
FROM node:alpine as build

WORKDIR /app
COPY package.json package-lock.json /app/

RUN npm install --force

COPY . /app
RUN npm run build --configuration=production

# Stage 2: Serve app with nginx server
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

LABEL org.opencontainers.image.source="https://github.com/Satyam-Malviya/Satyam-Malviya.github.io"
LABEL org.opencontainers.image.description="Docker Image of Satyam Malviya's Personal Portfolio."

EXPOSE 80
