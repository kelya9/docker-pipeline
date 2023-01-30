FROM httpd:alpine
RUN mkdir /web-app
WORKDIR /web-app
COPY . /web-app
COPY  /web-app/index.html /usr/local/apache2/htdocs/  
EXPOSE 80
CMD ["httpd-foreground"]
