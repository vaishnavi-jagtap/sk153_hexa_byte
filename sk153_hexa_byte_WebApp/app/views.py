import pymongo as pym

Conn = pym.MongoClient('mongodb+srv://jalshaktiAdmin:jsadmin@cwc.eevs6.mongodb.net/dynamicDB?retryWrites=true&w=majority')
db = Conn.dynamicDB