
#----------------------------------------Imports and routes for Web module------------------------
import bcrypt
import json
from app import serverApplication
from flask import render_template, redirect, url_for, request, flash, session, jsonify
from app.forms import AdminForm, LoginForm, RegistrationForm
from app.views import db
from app.surveyData import mongo2csv
from app.finalHealthCard import getHealthValues
from app.dropdown import getDistrict
from app.dropdown import getDistrict
from app.dropdown import getIndia

State=""
District=""

#for home url
@serverApplication.route('/')
@serverApplication.route('/index')
def index():
        print(serverApplication.config['MONGO_URI'])
        return render_template('index.html')

#authenticate admin and route to '/admin'
@serverApplication.route("/adminlogin", methods=['GET','POST'])
def adminlogin():
      form = AdminForm()
      if form.validate_on_submit():
            adminid = form.adminID.data ; password = form.password.data
            if len(list(db.admin.find({'$and':[{'id':adminid}, {'password':password}]}))) == 0:
                  print('No such admin')
                  return redirect(url_for('index'))
            else:
                  return render_template('adminopt.html')
      return render_template('adminlogin.html', form = form)

#login
@serverApplication.route('/login', methods=['POST','GET'])
def login():
    form = LoginForm()
    users = db.authority
    if request.method == 'POST':
        login_user = users.find_one({'username': request.form['username']})
        if login_user:
                if login_user['password'] ==  login_user['password'] :
                    session[str(request.form['username'])] = 1
                    flash(f'Logged In successfully {form.username.data}!', 'success')
                    # return redirect(url_for('index', user = request.form['username']))
                    return render_template('loginview.html')
                else:
                    flash(f'Invalid Username/Password {form.username.data}!', 'danger')
    return render_template('login.html', form=form)


#register
@serverApplication.route('/register', methods=['POST', 'GET'])
def register():
    form = RegistrationForm()
    if request.method == 'POST':
        users = db.authority        #data is collection name
        existing_user = users.find_one({'username': request.form['username']})

        if existing_user is None:
            hashpass = bcrypt.hashpw(request.form['password'].encode('utf-8'), bcrypt.gensalt())
            users.insert({'username': request.form['username'],
                          'password': hashpass,
                          'employeename': request.form['employeename'],
                          'state':request.form['state'],
                          'district':request.form['district'],
                          'email':request.form['email']})
            session['username'] = request.form['username']
            flash(f'Account created for {form.username.data}!', 'success')
            # return redirect(url_for('index'))
            return render_template('login.html')

        flash(f'Username already exist for {form.username.data}!', 'danger')
    return render_template('register.html',form=form)

@serverApplication.route("/about")
def about():
    return render_template("about.html")
#------------------------------------------------------------------------------------------------------

#JAID{
@serverApplication.route('/webmap')
def Webmap():
        return render_template('webmap.html')
# JAID}

@serverApplication.route('/getdata')
def getdata():
      for i in db.embankpart.find({},{'_id':0}):
            return jsonify({'data':i})

@serverApplication.route('/pdf')
def pdf():
    return render_template('toPDF.html')

@serverApplication.route('/fetchSurvey')
def dynamicSurvey():
    mongo2csv(csvFile="./app/static/surveyData.csv")
    user = {'nickname': 'JAID'}  # fake user
    return redirect('/scene')


@serverApplication.route('/scene')
def scene():
    user = {'nickname': 'JAID'}  # fake user
    return render_template('arcscene.html',
                           title='Datas',
                           user=user)

@serverApplication.route('/heatmap')
def heatmap():
    user={'nickname':'Jaid'}
    return render_template('heatmap.html')

@serverApplication.route('/hc')
@serverApplication.route('/healthcard')
def healthcard():
    India = getIndia()
    healthcard=getHealthValues(State=State,District=District)
    user={'nickname':'Jaid'}
    return render_template('healthcard.html',healthcard=healthcard,India=India)

@serverApplication.route('/d')
def Dropdown():
    India=getIndia()
    return render_template('dropdown.html',title='Dropdown',India=India)

@serverApplication.route('/ds', methods=['GET', 'POST'])
def change_state():
    global State
    State = request.args['selected']
    print (getDistrict(State))
    return jsonify(getDistrict(State))

@serverApplication.route('/dd', methods=['GET', 'POST'])
def change_district():
    global District
    District = request.args['selected']
    globalValues()
    return jsonify(District)

def globalValues():
    print("gvGLOBAL :"+State+" , "+District)

#jaid{

@serverApplication.route('/addzone')
def addzone():
    return render_template('addzone.html')

@serverApplication.route('/addtozone' ,methods=['GET', 'POST'])
def addtozone():
    from Addtozone import getzone
    Loc = request.args['selected']
    ZoneName=request.args['zone']
    myzone=getzone(loc=Loc,zoneName=ZoneName)
    return jsonify(myzone)

# jaid}