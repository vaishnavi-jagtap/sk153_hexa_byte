


def passZonetoDB(zoneName='',longitude=0.0,latitude=0.0):
    print("Zone :"+zoneName+" ,longitude :" + str(longitude) + ", latitude :" + str(latitude))
    import pymongo as pym

    #parts = [[72.5664169101, 22.9985715487], [72.5753398889, 23.0127055471], [72.5741977476, 23.0306942723],[72.5774100199, 23.0531801788], [72.5956128966, 23.0666241335]]
    #part_name = ['G1', 'G2', 'G3', 'G4', 'G5']
    part_name=[]
    parts=[]
    parts.append([longitude,latitude])
    part_name.append(zoneName)

    emb = dict(zip(part_name, parts))
    print(emb)

    client =pym.MongoClient('mongodb+srv://jalshaktiAdmin:jsadmin@cwc.eevs6.mongodb.net/dynamicDB?retryWrites=true&w=majority')

    db = client["dynamicDB"]
    surveys_collection = db["embankpart"]

    datas = surveys_collection.find()
    newDict=datas[0]
    newDict[zoneName]=[longitude,latitude]
    print(newDict)
    #'_id': ObjectId('5f27111a322f6eeaef34fc69')
    res=surveys_collection.update_one({},{'$set':newDict})
    print(res)

    client.close()


    return 1







def getzone(loc='',zoneName=''):
    zone=loc.split(',')

    long=zone[0].encode('ascii', 'ignore')
    longg=[]
    if(long[-1]=='N'):
        longg=long.split('N')
    elif(long[-1]=='S'):
        longg = long.split('S')

    latt=[]
    lat = zone[1].encode('ascii', 'ignore')
    if (lat[-1] == 'E'):
        latt = lat.split('E')
    elif (lat[-1] == 'W'):
        latt = lat.split('W')

    longitude=float(longg[0])
    latitude=float(latt[0])

    myZoneName=zoneName.encode('ascii', 'ignore')

    #print("longitude :"+str(longitude)+", latitude :"+str(latitude))
    passZonetoDB(zoneName=myZoneName,longitude=longitude,latitude=latitude)

    return 1

