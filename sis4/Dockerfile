FROM klakegg/hugo:latest AS builder
WORKDIR /src
COPY site/ .
RUN hugo

FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]