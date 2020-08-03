import pymongo
from app import serverApplication

healthQuestions={
    "1": "Current speed of water",
    "2": "Provision for removal of surface runoff water",
    "3": "Type of crack",
    "4": "Vegetation responsible for cracks",
    "5": "Type of vegetation",
    "6": "Type of embankment",
    "7": "Type of flexible mattress",
    "8": "Misalignment due to settlement",
    "9": "Misalignment due to seepage",
    "10": "Soil erosion",
    "11": "Pits/Holes/Destroyed structures",
    "12": "Cracks",
    "13": "Revetment",
    "14": "Area protected by the embankment",
    "15": "Water collection over the top of the embankment"
}

healthAnswers={
    "1":  [ "High" , "Medium" , "Low" ],
    "2":  [ "Yes" , "No" ],
    "3":  [ "Longitudinal" , "Transverse" , "Desiccation" , "No cracks" ],
    "4":  [ "Yes" , "No" ],
    "5":  [ "Grass" ,"Short-length Plants" , "Trees" , "No Vegetation" ],
    "6":  [ "Mattress Embankment" ,"Cement/Concrete Embankment","Block Embankment" ,"Stone Embankment" , "Earthen Embankment" , "Others" ],
    "7":  [ "Fabric Mattress" ,"Vegetation Mattress","Concrete Block Mattress" ,"No mattress available"],
}

uniqueOptions = {
    '1': 3,
    '2': 2,
    '3': 4,
    '4': 2,
    '5': 4,
    '6': 6,
    '7': 4
}

def fetchSurveyData(dbName='dynamicDB',collectionName='approvedSurveys',State='Gujarat',District=''):
    MongoURI = serverApplication.config['MONGO_URI']
    client = pymongo.MongoClient(MongoURI)
    db = client[dbName]
    surveys_collection = db[collectionName]

    datas = surveys_collection.find({"state":State})
    Surveryforms=[]
    for d in datas:#d['districts'] is array[ 0:object{data:"",name:""} ]
        #Surveryforms=d['districts'][0]['data']#print(Sdata)
        sizemax=len(d['districts'])
        for i in range(0,sizemax):
            Surveryforms = Surveryforms+d['districts'][i]['data']
    return Surveryforms

def getZonesList(Surveryforms):
    allzones=[]
    for forms in Surveryforms:
        allzones.append(forms['zone_id'])
    allzones=list(set(allzones))
    return allzones

def detailedmcqform(zoneMCQ,Surveryforms,question):

    for embz in zoneMCQ:
        ansList = []
        for form in Surveryforms:
            if(form['zone_id']==embz[0]):
                if(int(question)<=6):
                    ansList.append(form['survey-data']["detailed"]['multiple-choice'][question])
                elif(int(question)>6):
                    ansList.append(form['survey-data']["detailed"]['slider'][question])
        embz[int(question) + 1].append(ansList)

    return zoneMCQ

def getZoneWiseQuestions(State,District):
    Surveryforms=fetchSurveyData(State=State,District=District)
    questions = ['0','1','2','3','4','5','6','7', '8', '9', '10', '11', '12', '13', '14']
    allzones = getZonesList(Surveryforms)

    ZoneWiseQuestions=[]
    for zone in allzones:
        ZoneWiseQuestions.append([zone])
    #zoneMCQ=[[u'GJ4'], [u'GJ5'], [u'GJ2'], [u'GJ3'], [u'GJ1']]
    for zone in ZoneWiseQuestions:
        for q in questions:
            zone.append([q])

    for q in questions:
        ZoneWiseQuestions=detailedmcqform(ZoneWiseQuestions,Surveryforms,q)

    """for analysis in ZoneWiseQuestions:
        print(analysis)"""

    return(ZoneWiseQuestions)

def unicodeToInt(unicodeList):
    intList=list()
    for u in unicodeList:
        intList.append(int(u))
    return  intList

def toPercent(a,b):
    return float(a)/float(b)*100

def mcqListProcessing(mcqList,question):
    mcqListProcessed=[]
    total=len(mcqList)
    for option in range(1,uniqueOptions[str(question)]+1):
        mcqListProcessed.append(toPercent(mcqList.count(option),total))

    return mcqListProcessed

def sliderListProcessing(sliderList,question):
    return float(sum(sliderList))/len(sliderList)

def getHealthParameters(State,District):
    HealthParameters=getZoneWiseQuestions(State,District)
    for hp in HealthParameters:
        for i in range(1,7+1):
            hp[i][1]=mcqListProcessing(unicodeToInt(hp[i][1]),question=i)
        for i in range(8,15+1):
            hp[i][1] = sliderListProcessing(hp[i][1], question=i)

    return HealthParameters

def mergeAns(AnsList,qno):
    OptionList=healthAnswers[str(qno)]
    MergeList=[]
    Size=len(OptionList)
    for i in range(Size):
        value=OptionList[i]+" : "+str(AnsList[i])+" % "
        MergeList.append(value)
    return MergeList

def getHealthValues(State,District):
    #from heathcard04 import getHealthParameters
    HealthParameters=getHealthParameters(State,District)

    for hp in HealthParameters:
        for ques in range(1,8):
            hp[ques][0]=healthQuestions[str(ques)]
            hp[ques][1]=mergeAns(hp[ques][1],ques)
        for ques in range(8,16):
            hp[ques][0] = healthQuestions[str(ques)]

    return HealthParameters
