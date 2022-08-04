#!/bin/sh

rm -f tmp/pids/server.pid

RAILS_ENV=$RAILS_ENV bin/rails server -b 0.0.0.0 -p $PORT
