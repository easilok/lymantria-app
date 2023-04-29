FROM node:16.16.0

# Creating app directory
WORKDIR /app

# Installing dependencies
COPY package*.json ./
RUN npm install --silent

# Transfer app contents to its directory
ADD . /app

ENV VITE_API_URL=${LYMANTRIA_API_ENDPOINT}

# Build the app using Webpack
# RUN npm run build

# Exposing needed port
EXPOSE 5173

CMD [ "npm", "run", "dev" ]

