from fastapi import FastAPI, Form, HTTPException, Depends, Request
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from BaseModels import *
from pymongo.results import InsertOneResult
import server
import json

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite todos los origenes
    allow_credentials=True,
    allow_methods=["*"],  # Permite todos los métodos
    allow_headers=["*"],  # Permite todos los headers
)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@app.post("/token")
async def token(request: TokenRequest):
    try:
        user = await server.get_token(request.username, request.password)
        return user   
    except HTTPException as e:
        raise HTTPException(status_code=400, detail=f"Incorrect username or password as {e}")
    

@app.post("/sign/up")
async def singup(user_data:UserSignup):
    try:
        user = await server.create_user(user_data.username, user_data.password, user_data.full_name, user_data.email, user_data.disabled)
        return user
    except HTTPException as e:
        raise HTTPException(status_code=500, detail=f"Failed to create user as {e}")



@app.post("/log/in")
async def signin(request: SignInRequest):
    try:
        user = await server.authenticate_user(request.username, request.password)
        return user
    except HTTPException as e:
        raise HTTPException(status_code=400, detail=f"Error described as {e}")





if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
