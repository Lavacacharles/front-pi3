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



def fake_hash_password(password: str):
    return "fakehashed" + password



async def get_token(password: str):
    
    client, collection = await connect_to_serverCredentials()
    
    consulta = {
            "token" : hash_password(password)
        }

    columns = {
        "_id":0,
        "username":1,
    }
    user = collection.find_one(consulta,columns)
    client.close()

    print(user)


    if not user:
        return False
    if not fake_hash_password(password) == user['hash_password']:
        return False
    
    return user


async def authenticate_user(token: str, password: str):

    client, collection = await connect_to_serverUsers()

    consulta = {
            "token" : token,
            "password" : password
        }

    columns = {
        "_id":0
    }
    user = collection.find_one(consulta,columns)

    client.close()
    if not user:
        return False
    if not fake_hash_password(password) == user['hashed_password']:
        return False
    return user

async def create_user(username: str, password: str, full_name:str, email:str, disabled:bool):
    client, collection = await connect_to_serverUsers()
    
    encodePassword = fake_hash_password(password)
    consulta = {
            "username": username,
            "password": password,
            "full_name": full_name,
            "email": email,
            "hashed_password": encodePassword,
            "disabled": disabled,
        }

    user = collection.insert_one(consulta)

    if not user:
        return False

    client.close()

    client, collection = await connect_to_serverCredentials()
    
    consulta = {
            "username": username,
            "password": password,
            "hashed_password": encodePassword ,
        }

    user = collection.insert_one(consulta)

    client.close()



    if not user:
        return False
    userOut = {
        "username": username,
        "password": password 
    }
    return userOut

fake_users_db = {
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "fakehashedsecret",
        "disabled": False,
    }
}
