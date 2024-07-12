from fastapi import HTTPException
from pymongo import MongoClient 
import hashlib

def hash_password(password):
    # Retorna la contraseña hasheada
    return hashlib.sha256(password.encode()).hexdigest()


async def connect_to_serverUsers():

    client = MongoClient("mongodb://localhost:27017/")

    db_name = "TU_BARRIO_USERS"

    collection_name = "USERS"
    
    db = client[db_name] #<- data base name
    
    if collection_name not in db.list_collection_names():
        
        db.create_collection(collection_name) #<- data collection name
    
    collection = db[collection_name]

    return client, collection

async def connect_to_serverCredentials():

    client = MongoClient("mongodb://localhost:27017/")

    db_name = "TU_BARRIO_USERS"

    collection_name = "CREDENTIALS"
    
    db = client[db_name] #<- data base name
    
    if collection_name not in db.list_collection_names():
        db.create_collection(collection_name) #<- data collection name
        return False
    
    collection = db[collection_name]

    return client, collection

async def connect_to_serverUserInfo():

    client = MongoClient("mongodb://localhost:27017/")

    db_name = "TU_BARRIO_USERS"

    collection_name = "USERSINFO"
    
    db = client[db_name] #<- data base name
    
    if collection_name not in db.list_collection_names():
        db.create_collection(collection_name) #<- data collection name
    
    collection = db[collection_name]

    return client, collection

async def create_user(username: str, password: str, full_name:str, email:str, disabled:bool):
    try:
        password_ = hash_password(password)
        consulta = {
            "username": username,
            "password":password_,
            "full_name": full_name,
            "email": email, 
            "disabled": disabled
        }
        
        client, collection = await connect_to_serverUserInfo()
        print(collection.insert_one(consulta))
        client.close()

        consulta = {
            "username": username,
            "password":password_,
        }

        client, collection = await connect_to_serverCredentials()
        print(collection.insert_one(consulta))
        client.close()

        return {
            "response": True
        }
    except HTTPException as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

async def get_token(username: str, password: str):
    try:
        password_ = hash_password(password)
        consulta = {
            "username": username,
            "hash_password":password_
        }
        
        client, collection = await connect_to_serverCredentials()
        print(collection.find_one(consulta))
        client.close()

        return {
            "response": True
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


async def authenticate_user(username: str, password: str):
                                                        
    try:
        password_ = hash_password(password)
        consulta = {
            "username": username,
            "hash_password":password_
        }
        
        client, collection = await connect_to_serverCredentials()
        print(collection.find_one(consulta))
        client.close()

        return {
            "response": True
        }
    except HTTPException as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
    






