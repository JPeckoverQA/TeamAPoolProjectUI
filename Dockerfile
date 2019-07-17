# base image
USER root
FROM node:10-alpine as build
RUN apt update
EXPOSE 4200
WORKDIR /build
#copy code in
COPY . .
#RUN npm config set registry http://$(ip route | grep default | awk '{print $3}'):8081/repository/npm-proxy
#angular installation
RUN NG_CLI_ANALYTICS=ci npm install -g @angular/cli
RUN NG_CLI_ANALYTICS=ci npm install
RUN npm  build
#nginx base image
FROM nginx:latest
WORKDIR /app
COPY --from=build /build/dist/TeamAPoolProjectUI
COPY nginx.conf /etc/nginx/nginx.conf


#do not need an entrypoint as the entrypoint is within nginx
