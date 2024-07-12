from pydantic import BaseModel

class UserSignup(BaseModel):
    username: str
    password: str
    full_name: str
    email: str
    disabled: bool = False

class TokenRequest(BaseModel):
    username: str
    password: str
class SignInRequest(BaseModel):
    username: str
    password: str
