# INSECURE DOCKERFILE
FROM node:14

# Set working directory
WORKDIR /usr/src/app

# Copy package files first (bad practice: copy everything before npm install can cache)
COPY . .

# Install dependencies (no verification, might include vulnerable packages)
RUN npm install

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "server.js"]

