# # INSECURE DOCKERFILE
# FROM node:14

# # Set working directory
# WORKDIR /usr/src/app

# # Copy package files first (bad practice: copy everything before npm install can cache)
# COPY . .

# # Install dependencies (no verification, might include vulnerable packages)
# RUN npm install

# # Expose port
# EXPOSE 3000

# # Start app
# CMD ["node", "server.js"]


# Secure dockerfile
# Use an official Node.js runtime as a parent image
FROM node:20

# Create a non-root user and group
RUN groupadd -r appgroup && useradd -r -g appgroup -s /bin/bash -m appuser

# Set working directory
WORKDIR /usr/src/app

# Copy package files first (to leverage Docker cache)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Change ownership to the non-root user
RUN chown -R appuser:appgroup /usr/src/app

# Switch to the non-root user
USER appuser

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "server.js"]
