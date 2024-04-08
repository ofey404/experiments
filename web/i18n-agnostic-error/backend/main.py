from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

app = FastAPI()

# quick and dirty CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update this with the allowed origins
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["*"],
)

@app.post("/api/get")
def get():
    return JSONResponse(status_code=400, content={
        "code": 10001,
        "message": "Invalid request from user test_user, ID 1",
        "values": {
            "user": "test_user",
            "id": 1
        }
    })


if __name__ == "__main__":
    uvicorn.run("main:app", host="localhost", port=8888)