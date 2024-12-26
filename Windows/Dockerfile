# Use the official Node.js image for Linux
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Copy the necessary files into the container
COPY ./public /app/public
COPY ./server.js /app
COPY ./package*.json /app

# Install required npm packages
RUN npm install

# Expose port 3000
EXPOSE 3000

# Command to run server.js
CMD ["node", "server.js"]
