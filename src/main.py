"""FastAPI main module"""

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    """
    fastapi root endpoint
    Returns:
        dict
    """
    return {"message": "Hello World"}

