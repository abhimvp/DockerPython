# DockerPython

Containerization of Python Applications using Docker, an open-source platform that streamlines building, deploying, and running applications with a few powerful tools—like the Docker Engine, CLI, and Compose. setting up a simple FastAPI app. [Ref](https://youtu.be/_tIZp1y6KV4?si=aUSzDLHblxAMLnl1).

![Docker Architecture](Images/image.png)

- A container is an isolated environment for your code.[(Getting Started Guide)](https://docs.docker.com/get-started/) & Understand [Architecture](https://docs.docker.com/get-started/docker-overview/#docker-architecture) in general.
- Images are used to run containers - You can either build an image from a Dockerfile, or download an existing image to run.

```txt

C:\Users\abhis>docker

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
  run         Create and run a new container from an image
  exec        Execute a command in a running container
  ps          List containers
  build       Build an image from a Dockerfile
  pull        Download an image from a registry
  push        Upload an image to a registry
  images      List images
  login       Log in to a registry
  logout      Log out from a registry
  search      Search Docker Hub for images
  version     Show the Docker version information
  info        Display system-wide information

```

## Simple_FastApi_Todos

- Create the Virtual Environment we need - `python -m venv env` - to add our installed dependencies & then we activate it - `source env/Scripts/activate`.
- now we install the framework/dependencies that we're going to use.
  - `pip install fastapi[standard]` - When you install `fastapi[standard]`, you're essentially getting FastAPI plus a selection of commonly used and recommended extra packages. These extras enhance FastAPI's capabilities in various ways like it includes `uvicorn[standard]`. Uvicorn is an ASGI (Asynchronous Server Gateway Interface) web server.pull in optimized JSON handling libraries like `orjson` or `ujson`. These libraries are much faster than Python's built-in json module, which is crucial for API performance.python-multipart is installed. This package is necessary for handling form data, especially when dealing with file uploads.`httpx` is installed, which is used for the test client.jinja2 which is used for templating.Key takeaway: `fastapi`: Core functionality,`fastapi[standard]`: Core functionality + performance enhancements + common utilities.
  - create the `requirements.txt` file that's going to help us keep track of the packages or dependencies of our project as well as their specific versions.we run `pip freeze > requirements.txt`
  - create a `src` folder and make it a python package by creating `__init__.py` file inside of that folder/directory.
  - used `hw` - A [FastAPI snippets](https://marketplace.visualstudio.com/items?itemName=damildrizzy.fastapi-snippets) for VsCode - to create `FastAPI hello world`
