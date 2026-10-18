FROM node:22-alpine AS build
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN LG_COPY_PUBLIC=0 npx vite build

FROM nginx:1.27-alpine
COPY --from=build /src/dist /srv/dist
COPY --from=docker nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
