# Use the official Parrot OS base image
FROM parrotsec/core:latest

# Update the package list and install necessary tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    build-essential \
    python3 \
    gcc \
    g++ \
    make && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y --no-install-recommends \
    nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app/EDS

# Create the public directory and copy files
RUN mkdir -p /app/EDS/public
COPY ./public /app/EDS/public
COPY server.js /app/EDS

# Install required npm packages
RUN npm install express ws node-pty

# Expose port 3000
EXPOSE 3090

# Command to run server.js
CMD ["node", "/app/EDS/server.js"]

