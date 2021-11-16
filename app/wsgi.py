import os

from flask import Flask


def create_app(package_name, settings=None):
    """
    This function creates the application using the application factory pattern.
    Extensions and blueprints are then initialized onto the the application
    object.
    http://flask.pocoo.org/docs/0.11/patterns/appfactories/
    
    :param package_name: the name of the package
    :param settings: override default settings via a python object
    :return: app: the main flask application object
    """
    app = Flask(package_name)

    if settings:
        app.config.update(settings)

    return app


settings = {}

app = create_app(__name__, settings=settings)

@app.route("/", methods=["GET"])
def index():
    return "Hello World!"


if __name__ == '__main__':  
    port = int(os.environ.get('FLASK_PORT', 5000))
    host = os.environ.get('FLASK_HOST', '0.0.0.0')
    app.run(host=host, port=port)
