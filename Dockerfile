FROM node:18.20.0-alpine3.18
RUN mkdir -p /app
WORKDIR /app
COPY . .

RUN npm run build
RUN npm run export

EXPOSE 3000
CMD ["npm", "start"]