### A simple flask app with docker and heroku

1. Make a new directory

2. Install flask and gunicorn with pipenv: 

```bash
pipenv install flask gunicorn
```

3. make your flask app and test it:

```bash
mkdir my_app && \
touch my_app/__init__.py && \
touch my_app/views.py && \
touch my_app/wsgi.py
```
To the __init__.py file add:

```python
from flask import Flask 

app = Flask(__name__)

from .views import *
```

For views.py add:
```python
from my_app import app

@app.route("/", methods=["GET"])
def hello_world():
    return "Hello world, this is flask"
```

And to wsgi.py add:

```python
import os
from my_app import app

if __name__=="__main__":
    port = os.environ.get("PORT") or 5000
    app.run(port=port)
```

Also make a file called ```run.sh``` and add ```gunicorn my_app.wsgi:app```

After you create that file run ```chmod +x run.sh``` in your terminal. 

Next make sure you are in your virtual env by running ```pipenv shell``` and now you can execute the command:  ```./run.sh``` in your terminal. 

You should see: Hello world, this is flask at http://127.0.0.1:8000, and if so everything is working locally so you can move to the next step.

4. Make your Dockerfile and build it

Create a file called Dockerfile and add the following:
```Dockerfile
# Base Image
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

CMD gunicorn run:app --bind 0.0.0.0:$PORT

```

You can make another file called build.sh and add the build command to it:

```bash
docker build -t flask-app -f Dockerfile .
```

After this you can ```./build.sh``` in the terminal











