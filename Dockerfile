# Use the official Node.js image as the base
FROM node:21-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the app source code to the container
COPY . .

# Build the Next.js app
RUN npm run build

# Install serve to serve the static site
RUN npm install -g serve

# Use a new stage to keep the final image small
FROM node:21-alpine

# Copy the built site and the serve command from the builder stage
COPY --from=builder /app/out /app/out
COPY --from=builder /usr/local/bin/serve /usr/local/bin/serve

# Expose the port the app will run on
EXPOSE 3000

# Start the app with serve
CMD ["serve", "-s", "app/out", "-p", "3000"]