# Use the official Node.js image as the base
FROM node:21-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or npm-shrinkwrap.json) to the container
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the app source code to the container
COPY . .

# Build the Next.js app
RUN npm run build
RUN npm run export

# Install a simple http server for serving static content
RUN npm install -g http-server

# Use a new stage to keep the final image small
FROM node:21-alpine

# Copy the built site from the builder stage
COPY --from=builder /app/out /app

# Install http-server to serve the static site
COPY --from=builder /usr/local/bin/http-server /usr/local/bin/http-server

# Expose the port the app will run on
EXPOSE 3000

# Start the app with http-server
CMD ["http-server", "app", "-p 3000"]