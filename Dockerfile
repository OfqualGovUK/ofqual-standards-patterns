# Stage 1: Build the site
FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build  # or 'npx @11ty/eleventy'

# Stage 2: Serve the site
FROM nginx:alpine
# Copy built files from Stage 1 to Nginx
COPY --from=build /app/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]