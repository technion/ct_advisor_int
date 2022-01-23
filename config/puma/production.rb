#!/usr/bin/env puma
environment 'production'
pidfile 'tmp/pids/puma.pid'
workers 0
bind 'tcp://127.0.0.1:8082'
