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

- Now for us to containerize this , we are going to need a `DockerFile`, which is going to be a `blueprint` or a `set of steps` that shall be needed to build our application into an image.So Image is what docker will transform into a container. Which is going to be a process on our machine that's going to run our application plus all our dependencies.
  - Docker can build images automatically by reading the instructions from a [Dockerfile](https://docs.docker.com/reference/dockerfile/#overview). A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.
  - Docker `runs` `instructions` in a Dockerfile `in order`. A Dockerfile must begin with a `FROM` instruction.
  - You can use [`.dockerignore`](https://docs.docker.com/build/concepts/context/#dockerignore-files) file to exclude files and directories from the build context.This helps avoid sending unwanted files and directories to the builder, improving build speed, especially when using a remote builder.When you run a `build` command, the build client looks for a file named .dockerignore in the root directory of the context. If this file exists, the files and directories that match patterns in the files are removed from the build context before it's sent to the builder.
- also we can run fastapi using [fastapiCLI](https://fastapi.tiangolo.com/fastapi-cli/).To run your FastAPI app for development, you can use the fastapi dev command:

```bash
fastapi dev main.py
# to run at specific port , we can use --port
fastapi dev src/main.py --port 8005
# we will use following command in DockerFile
fastapi dev src/main.py --host 0.0.0.0 --port 8005
```

- FastAPI CLI takes the path to your Python program (e.g. main.py) and automatically detects the FastAPI instance (commonly named `app`), determines the correct import process, and then serves it.
- For production you would use fastapi run instead. 🚀
- Internally, FastAPI CLI uses Uvicorn, a high-performance, production-ready, ASGI server. 😎
- Refer :

```bash
docker build --help

-t, --tag stringArray               Name and optionally a tag (format:"name:tag")
    --target string                 Set the target build stage to build
    --ulimit ulimit                 Ulimit options (default [])
```

- let's give a name to our image using -t tag.

```bash
docker build -t simple_fastapiapp:v1 .

# We see the following
$ docker build -t simple_fastapiapp:v1 .
[+] Building 2.7s (10/10) FINISHED docker:desktop-linux
 => [internal] load build definition from Dockerfile
 => => transferring dockerfile: 619B
 => [internal] load metadata for docker.io/library/python:3.12-slim 1.1s
 => [internal] load .dockerignore 0.0s
 => => transferring context: 83B 0.0s
 => [1/5] FROM docker.io/library/python:3.12-slim@sha256:a866731a6b71c4a194a845d86e06568725e430ed21821d0c52e4efb385cf6c6f 0.0s
 => [internal] load build context 0.0s
 => => transferring context: 386.37kB 0.0s
 => CACHED [2/5] WORKDIR /app 0.0s
 => CACHED [3/5] COPY requirements.txt . 0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir -r requirements.txt 0.0s
 => [5/5] COPY . . 0.9s
 => exporting to image  0.6s
 => => exporting layers  0.5s
 => => writing image sha256:a5290051769425ae134ba568197669c632c94478b1cd51840aec7b21cf4dfeb7  0.0s
 => => naming to docker.io/library/simple_fastapiapp:v1
```

-- Now our Image is ready and we can confirm that as follows.And we can see `v1` as `TAG`

```bash
$ docker image ls
REPOSITORY          TAG       IMAGE ID       CREATED         SIZE
simple_fastapiapp   v1        a52900517694   5 minutes ago   262MB
<none>              <none>    0fb1a7c5dcda   6 minutes ago   262MB
```

- Now for us to run this image as a container as a process of it's own - we do `docker run`.

```bash
$ docker run --help

Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

Create and run a new container from an image

-p, --publish list                     Publish a container's port(s) to the host
# below i'm mapping docker 8003 to local 8003 port
```

- let's run

```bash
$ docker run -p 8003:8003 simple_fastapiapp:v1

   FastAPI   Starting development server 🚀

             Searching for package file structure from directories with
             __init__.py files
             Importing from /app

    module   📁 src
             ├── 🐍 __init__.py
             └── 🐍 main.py

      code   Importing the FastAPI app object from the module with the following
             code:

             from src.main import app

       app   Using import string: src.main:app

    server   Server started at http://0.0.0.0:8003
    server   Documentation at http://0.0.0.0:8003/docs

       tip   Running in development mode, for production use: fastapi run

             Logs:

      INFO   Will watch for changes in these directories: ['/app']
      INFO   Uvicorn running on http://0.0.0.0:8003 (Press CTRL+C to quit)
      INFO   Started reloader process [1] using WatchFiles
      INFO   Started server process [8]
      INFO   Waiting for application startup.
      INFO   Application startup complete.
```

- now our app is running inside of a container , can confirm that as follows :

```bash
$ docker ps # list's the running containers.
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                    NAMES
b4d20e4f0b1e   simple_fastapiapp:v1   "fastapi dev src/mai…"   2 minutes ago   Up 2 minutes   0.0.0.0:8003->8003/tcp   elated_margulis
(env)
```

```bash
$ docker container ls
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                    NAMES
b4d20e4f0b1e   simple_fastapiapp:v1   "fastapi dev src/mai…"   5 minutes ago   Up 5 minutes   0.0.0.0:8003->8003/tcp   elated_margulis
```

- To Stop the container

```bash
$ docker container stop b4d20e4f0b1e
b4d20e4f0b1e
$ docker container ls
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

- we can run commands inside container by using docker cli , like running migrations and all.

```bash
$ docker container ls
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                    NAMES
ab5f1db747ba   simple_fastapiapp:v1   "fastapi dev src/mai…"   5 seconds ago   Up 5 seconds   0.0.0.0:8003->8003/tcp   beautiful_benz
(env)
abhis@Tinku MINGW64 ~/Desktop/PythonDev/DockerPython (main)
$ docker exec -it ab5f1db747ba bash
root@ab5f1db747ba:/app# ls
Dockerfile  Images  README.md  env  requirements.txt  src
root@ab5f1db747ba:/app#
What's next:
    Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug ab5f1db747ba
    Learn more at https://docs.docker.com/go/debug-cli/
```
