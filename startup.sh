#!/usr/bin/env sh
set -e

echo "PATH=$PATH"
ls -la /app/.venv/bin || true
command -v python || true
python -c "import sys; print('exe=', sys.executable); print('ver=', sys.version)"

# Simple start up script to use in docker so that we can build the DB and then run the server.
python manage.py migrate

python manage.py runserver 0.0.0.0:8000