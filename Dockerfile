# Stage 1: Build Project
FROM node:20 AS build

WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# Stage 2: Serve With Nginx
FROM nginx:alpine

# copy config of nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build to nginx serve folder
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
