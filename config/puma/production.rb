#!/usr/bin/env puma
daemonize
environment 'production'
pidfile 'tmp/pids/puma.pid'
workers 2
bind 'tcp://127.0.0.1:8082'
