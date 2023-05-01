FROM node:16.13.1-alpine as build

# Creating app directory
WORKDIR /app

# Installing dependencies
COPY package*.json ./
RUN npm install --silent

# Transfer app contents to its directory
ADD . /app

ARG LYMANTRIA_API_ENDPOINT
ENV VITE_API_URL=${LYMANTRIA_API_ENDPOINT}

# Build the app using Webpack
# RUN npm run build

# Exposing needed port
# EXPOSE 5173

# CMD [ "npm", "run", "dev" ]

RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
# react router
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

