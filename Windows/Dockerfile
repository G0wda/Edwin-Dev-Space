# Use the official Node.js Windows image
FROM mcr.microsoft.com/windows/node:lts

# Set the working directory
WORKDIR C:/app/EDS

# Create the public directory and copy files from local
RUN mkdir public
COPY ./public C:/app/EDS/public
COPY server.js C:/app/EDS
COPY package*.json C:/app/EDS

# Install required npm packages
RUN npm install express ws node-pty

# Expose port 3000
EXPOSE 3000

# Command to run server.js
CMD ["node", "server.js"]
