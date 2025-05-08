# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Use your custom script that installs react-scripts and then builds
RUN npm run install-and-build

# Stage 2: Production
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]