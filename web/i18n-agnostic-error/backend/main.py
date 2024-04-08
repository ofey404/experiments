from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
import uvicorn

app = FastAPI()

@app.post("/api/get")
def get():
    return JSONResponse(status_code=400, content={
        "code": 10001,
        "message": "Invalid request from user test_user, ID 1",
        "values": ["test_user", 1]
    })


if __name__ == "__main__":
    uvicorn.run("main:app", host="localhost", port=8888)