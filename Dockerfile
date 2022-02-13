FROM python:3.9-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app

COPY manage.py poetry.lock pyproject.toml /usr/src/app/

RUN pip3 install poetry

RUN poetry install

COPY cali cali

CMD poetry run python manage.py runserver 0.0.0.0:8080