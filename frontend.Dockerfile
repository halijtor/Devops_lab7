FROM node:16-alpine AS build
WORKDIR /app
COPY react-frontend/package.json react-frontend/package-lock.json ./
RUN npm ci
COPY react-frontend/public ./public
COPY react-frontend/src ./src
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

