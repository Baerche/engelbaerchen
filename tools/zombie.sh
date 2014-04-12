#!/bin/sh
set -eu
coffee  -o tools/gen -c tools/*.coffee
coffee tools/zombie.coffee

#../bin/parse log
