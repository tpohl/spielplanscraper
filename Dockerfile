# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Thorsten Pohl <thpohl@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev  && \
    rm -rf /var/lib/apt/lists/*

# Install apache

RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/*
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

# Install Scrapy
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/* \
    && pip install cryptography 
#x    && apt-get purge -y --auto-remove gcc 
RUN pip install scrapy

# Define working directory
WORKDIR /data

# Define default command
CMD ["bash"]
