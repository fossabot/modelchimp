#!/bin/sh -

# Creating some dummy assets
mkdir -p media/profile
cp profile_pic.png media/profile/profile_pic.png

# Setting up the server
python3 /code/manage.py migrate
python3 manage.py create_super_user --email admin@modelchimp.com --password modelchimp123
python3 /code/manage.py set_domain
gunicorn --access-logfile - --workers 3 -b 0.0.0.0:8002 settings.wsgi:application
