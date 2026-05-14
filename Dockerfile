# Stage 1: Build the site
FROM node:22 AS build
WORKDIR /app
COPY package*.json ./
COPY .github ./.github

RUN npm install
COPY . .
RUN npm run build  # or 'npx @11ty/eleventy'

# Stage 2: Serve the site
FROM nginx:alpine
# Copy built files from Stage 1 to Nginx
COPY --from=build /app/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]