# Use the official Parrot OS base image
FROM parrotsec/core:latest

# Update the package list and install Node.js and npm
RUN apt-get update && \
    apt-get install -y nodejs npm

# Set the working directory
WORKDIR /app/EDS

# Create and copy files to the public directory
RUN mkdir public
COPY ./public /app/EDS/public
COPY server.js /app/EDS

# Install required npm packages
RUN npm install express ws node-pty

# Expose port 3000
EXPOSE 3000

# Command to run server.js
CMD ["node", "server.js"]
