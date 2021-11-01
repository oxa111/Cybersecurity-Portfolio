#!/bin/bash
rm -r /tmp/*
rm -r /var/tmp/*
apt clean -y
rm -r /home/systemadmin/.cache/thumbnails
