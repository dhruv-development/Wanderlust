# Base image
FROM node:22-slim

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy source code
COPY . .

# Copy environments
COPY .env.sample .env

# Expose port
EXPOSE 5000

# Start the server
CMD ["npm", "start"]
