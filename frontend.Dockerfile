FROM node:16-alpine AS build
WORKDIR /app
COPY react-frontend/package.json react-frontend/yarn.lock ./
RUN yarn install --frozen-lockfile
COPY react-frontend/ ./
RUN yarn build
FROM nginx:alpine
RUN addgroup -S appuser && adduser -S appuser -G appuser appuser
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
USER appuser

