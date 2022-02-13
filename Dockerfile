FROM python:3.9-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app

COPY manage.py poetry.lock pyproject.toml /usr/src/app/

RUN pip3 install poetry

RUN poetry install

RUN poetry export -f requirements.txt --output requirements.txt

RUN pip install -r requirements.txt

COPY cali cali

CMD python manage.py runserver 0.0.0.0:8080