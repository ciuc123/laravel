#!/bin/bash
chmod -R 777 storage bootstrap/cache
exec "$@"

