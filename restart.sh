#!/bin/bash
echo "Reseting database"
rake db:reset
rake db:test:prepare
