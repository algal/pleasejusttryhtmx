#!/usr/bin/env bash
exec rsync -a --exclude='.git/' /home/algal/gits/pleasejusttryhtmx/ /usr/share/caddy/files/htmx/
