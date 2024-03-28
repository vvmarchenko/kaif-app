# Use the official Node.js image as the base
FROM node:21-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or npm-shrinkwrap.json) to the container
COPY package*.json ./

# Install dependencies including http-server for serving static content
RUN npm ci && npm install http-server

# Copy the app source code to the container
COPY . .

# Build the Next.js app
RUN npm run build


# Expose the port the app will run on
EXPOSE 3000

# Start the app with http-server
CMD ["npx", "http-server", "out", "-p", "3000"]