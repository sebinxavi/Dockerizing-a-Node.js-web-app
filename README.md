# Docker Container with simple Node.js Hello World application 

The goal of this example is to show you how to get a Node.js application into a Docker container. The guide is intended for development, and not for a production deployment. The guide assumes you have a basic understanding of how a Node.js application is structured.
We will create a simple web application in Node.js, then we will build a Docker image for that application, and lastly we will instantiate a container from that image.

## Prerequisites
- SSH root access to VPS/Dedicated Server

## Install Docker Engine

Docker Engine is available on a variety of Linux platforms, macOS and Windows 10 through Docker Desktop, and as a static binary installation. Please follow the Docker [officical Documention](https://docs.docker.com/engine/install/) for Docker Installation.

## Building the Docker image

I have already developed the Dockerfile and Node.js app and it is available in my [GitHub Repository](https://github.com/sebinxavi/Dockerizing-a-Node.js-web-app/)

### Node.js app

~~~sh
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
~~~

### Dockerfile

~~~sh
FROM alpine
RUN mkdir /var/nodejsapp
WORKDIR /var/nodejsapp
COPY . /var/nodejsapp
RUN apk update
RUN apk add nodejs npm
RUN npm init -y
RUN npm install express
EXPOSE 3000
ENTRYPOINT [ "node" ]
CMD [ "app.js" ]
~~~

Please perform the steps below to clone the github repository;

~~~sh
apt install git -y
git clone https://github.com/sebinxavi/Dockerizing-a-Node.js-web-app.git
~~~ 

Go to the directory that has the Dockerfile and run the following command to build the Docker image. The -t flag lets you tag your image so it's easier to find later using the docker images command:
~~~sh
cd Dockerizing-a-Node.js-web-app/
docker build -t <your username>/node-web-app> . 
~~~

![demo](https://i.ibb.co/Fb4tCQP/1.png)


Your image will now be listed by Docker by the command:
~~~sh
docker images ls
~~~

![alt text](https://i.ibb.co/NxhZn42/2.png)

Now run the container from the Image created:
~~~sh
docker container run --name nodejs -p 80:3000 -d <your username>/node-web-app>
~~~

![alt text](https://i.ibb.co/vJBHZYk/3.png)

To test your app, get the port of your app that Docker mapped:
~~~sh
docker container ls
~~~

![alt text](https://i.ibb.co/LxvcJCw/4.png)

In the example above, Docker mapped the 3000 port inside of the container to the port 80 on your machine.

Now you can test your app using curl or access the server IP through web browser
~~~sh
curl -I http://SERVER-IP:80
curl -L http://SERVER-IP:80
~~~
![alt text](https://i.ibb.co/Z1TK8P3/5.png)

![alt text](https://i.ibb.co/P1wqtmh/6.png)

You can also push this image to Docker Hub repositories

[Docker Hub repositories](https://docs.docker.com/docker-hub/repos/) allow you share container images with your team, customers, or the Docker community at large.

I have uploaded this Container Image to docker hub and you can download the image by

~~~sh
docker pull sebinxavi/node-web-app:1
~~~
