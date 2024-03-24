FROM node:alpine

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json


RUN npm install

COPY .next .next
COPY public public

EXPOSE 3000

CMD npm start