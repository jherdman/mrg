#!/bin/bash

bundle exec puma -b "tcp://0.0.0.0:${PUMA_PORT}"
