FROM python:3.7

RUN mkdir /app
WORKDIR /app

ADD . /app

ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN pip3 install --upgrade pip
RUN pip3 install pipenv

RUN pipenv install --skip-lock --system --dev

CMD gunicorn my_app.wsgi:app --bind 0.0.0.0:$PORT