from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)

def get_mongodb_info():
    client = MongoClient('mongodb://mongo-database:27017/')
    try:
        # Test the connection
        client.admin.command('ismaster')
        
        # Get list of databases
        databases = client.list_database_names()
        
        return {
            "status": "Connected",
            "databases": databases
        }
    except Exception as e:
        return {
            "status": "Failed to connect",
            "error": str(e)
        }
    finally:
        client.close()

@app.route('/')
def mongodb_status():
    info = get_mongodb_info()
    return jsonify(info)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3001)