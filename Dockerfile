FROM python:3.7.8-stretch
ENV TZ Europe/Berlin
ENV USER=root

RUN apt-get update && apt-get install -y gettext
RUN mkdir -p /opt/django-server

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
WORKDIR /opt/djangocms
COPY . .

# ENV PORT=8000
# ENV DB_HOST="localhost"
# ENV DB_PORT="5432"
# ENV DB_NAME="djangocms"
# ENV DB_USER="postgres"
# ENV DB_PASSWORD="qiIL9Hv6XYNz5D3LEaplBwxrYksxJJ"

# CMD python manage.py migrate
# CMD python /opt/djangocms/manage.py runserver 0.0.0.0:8000
CMD python manage.py collectstatic && python manage.py migrate && uwsgi --http=0.0.0.0:$PORT --module=my_demo.wsgi