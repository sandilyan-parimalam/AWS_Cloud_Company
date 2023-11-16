FROM nginx:latest
COPY Data/index.html /usr/share/nginx/html/
EXPOSE 80
CMD["nginx", "-g", "daemon off;"]