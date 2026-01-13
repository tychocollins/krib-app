# Use the Nginx image
FROM nginx:alpine

# Copy the build output to replace the default nginx contents.
COPY build/web /usr/share/nginx/html

# Update Nginx configuration to listen on port 7860 (Hugging Face default)
RUN sed -i 's/80/7860/g' /etc/nginx/conf.d/default.conf

# Expose port 7860
EXPOSE 7860

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
