#base image
FROM node:22-slim

#working directory
WORKDIR /app

#copy code into container
COPY . .

#install dependencies
RUN npm i

#copy environments
COPY .env.sample .env

#Expose port
EXPOSE 5000

#Run server
CMD ["npm","start"]
