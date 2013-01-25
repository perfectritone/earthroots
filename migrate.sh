#!/bin/bash
echo "Migrating database"
rake db:migrate
rake db:test:prepare
