FROM node:22-alpine

# set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

# will execute npm install in /home/app because of WORKDIR
COPY ./app/package*.json ./
RUN npm install

COPY ./app ./

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password

# create group and user to run the app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# set ownership and permissions for the app directory
RUN chown -R appuser:appgroup /home/app && chmod -R 755 /home/app

# switch to the new user
USER appuser

# no need for /home/app/server.js because of WORKDIR
CMD ["node", "server.js"]

