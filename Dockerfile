FROM node:14-alpine

RUN mkdir /app

WORKDIR /app

COPY ./app/images /app/images
COPY ./app/index.html /app/index.html
COPY ./app/package.json /app/package.json
COPY ./app/package-lock.json /app/package.-lock.json
COPY ./app/server.js /app/server.js

RUN npm install

CMD ["npm", "run", "start"]
