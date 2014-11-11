# Sample Rails App with Dockerfile

To build an image to run this application open up a terminal and from the root of this application run:

    $ docker build -t myapp --rm .

Then to run start a container run:

    $ docker run --name myapp -i -t --rm -p 5000:5000 -v /path/to/rails/root:/var/www myapp
