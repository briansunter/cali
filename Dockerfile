FROM python:3.9-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get -y install libpq-dev gcc 

COPY manage.py poetry.lock pyproject.toml /usr/src/app/

RUN pip3 install poetry

RUN poetry export -f requirements.txt --output requirements.txt

RUN pip install -r requirements.txt

COPY cali cali

ENV PORT=8080

CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 cali.wsgi:application
