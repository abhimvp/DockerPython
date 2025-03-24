# 1. create the base environment
FROM python:3.12-slim
# 2. set the working directory - where our application will be running
WORKDIR /app
# 3. copy the requirements file/ dependency list
COPY requirements.txt .
# 4. install the dependencies
RUN pip install --no-cache-dir -r requirements.txt
# 5. copy the source/app code - we are copying the entire directory
COPY . .
# 6. set the entrypoint - expose the port on which the application will be running
EXPOSE 8003
# 7. run the application
CMD ["fastapi", "dev" ,"src/main.py", "--host", "0.0.0.0", "--port", "8003"]