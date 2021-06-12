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
