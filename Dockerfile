# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Install Eleventy globally (optional)
RUN npm install -g @11ty/eleventy

# Default command
CMD ["npx", "eleventy", "--serve"]
