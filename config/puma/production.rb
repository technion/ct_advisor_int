#!/usr/bin/env puma
environment 'production'
pidfile 'tmp/pids/puma.pid'
workers 1
bind 'tcp://127.0.0.1:8082'
