# base image
FROM ubuntu:latest
USER root
RUN apt update
# install wget & curl
RUN apt install -y curl
#install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt install -y nodejs
RUN apt install -y build-essential
EXPOSE 4200
# angular installation
RUN NG_CLI_ANALYTICS=ci npm install -g @angular/cli
# configure server user
RUN useradd -m -s /bin/bash frontend
# make and change to application directory
WORKDIR /opt/frontend
# configure application directory permissions
RUN chown -R frontend:frontend .
# change to backend user
USER frontend
# copy code in
COPY . .
# get dependencies
RUN NG_CLI_ANALYTICS=ci npm install
# main process for the container when it runs
ENTRYPOINT ["/usr/bin/ng", "serve", "--host", "0.0.0.0", "-d"]
