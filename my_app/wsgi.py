import os
from my_app import app

if __name__=="__main__":
    port = os.environ.get("PORT") or 5000
    app.run(port=port)