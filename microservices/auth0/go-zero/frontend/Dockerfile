FROM nginx:alpine

COPY ./build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]
