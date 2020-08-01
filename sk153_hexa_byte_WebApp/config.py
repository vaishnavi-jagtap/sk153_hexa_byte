import os

#configuration for database connectivity and secret key configuration
class Config():
      SECRET_KEY=os.environ.get('SECRET_KEY')or'8a3f733cbf323ad0c521904374783741'
      MONGO_URI=os.environ.get('MONGO_URI')or'mongodb+srv://jalshaktiAdmin:jsadmin@cwc.eevs6.mongodb.net/dynamicDB?retryWrites=true&w=majority'