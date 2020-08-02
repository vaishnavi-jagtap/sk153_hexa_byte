
#----------------------------------------Imports and routes for Web module------------------------
import bcrypt
from app import serverApplication
from flask import render_template, redirect, url_for, request, flash, session
from app.forms import AdminForm, LoginForm, RegistrationForm
from app.views import db

#for home url
@serverApplication.route('/')
@serverApplication.route('/index')
def index():
    if 'username' in session:
        flash(f'You are logged in as ' + session['username'], 'success')
    return render_template('index.html')


#authenticate admin and route to '/admin'
@serverApplication.route("/adminlogin", methods=['GET','POST'])
def adminlogin():
      form = AdminForm()

      if form.validate_on_submit():
            adminid = form.adminID.data ; password = form.password.data
            if len(list(db.admin.find({'$and':[{'id':adminid}, {'password':password}]}))) == 0:
                  print('No such admin')
            else:
                  return render_template('Layout.html',status = 1)

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
                    session['username'] = request.form['username']
                    flash(f'Logged In successfully{form.username.data}!', 'success')
                    return redirect(url_for('index'))
                else:
                    flash(f'Invalid Username/Password {form.username.data}!', 'danger')
    return render_template('login.html', title='Login', form=form)


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
            return redirect(url_for('index'))

        flash(f'Username already exist for {form.username.data}!', 'danger')
    return render_template('register.html',form=form,title='register')
#------------------------------------------------------------------------------------------------------
