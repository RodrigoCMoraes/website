FROM ubuntu:noble AS builder

WORKDIR /builder
RUN apt-get update && apt install -y hugo
COPY . .
RUN hugo

FROM nginx:stable-alpine3.19-slim
COPY --from=builder /builder/public/ /var/www/website/
COPY nginx.conf /etc/nginx/nginx.conf