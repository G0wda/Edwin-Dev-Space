# Use the official Ubuntu base image
FROM ubuntu:latest

# Update the package list and install Node.js and npm
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y  npm


# Set the working directory
WORKDIR /app/EDS

# Copy files from the local directory to the container
RUN mkdir public
COPY ./public /app/EDS/public
COPY server.js /app/EDS
COPY package*.json /app/EDS/ 

RUN npm install express ws node-pty
# Expose port 300
EXPOSE 3000

# Command to run server.js
CMD ["node", "server.js"]
