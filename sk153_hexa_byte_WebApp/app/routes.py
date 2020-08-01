#----------------------------------------Imports and routes for admin module------------------------
from app import serverApplication
from flask import render_template, redirect, url_for
from app.forms import AdminForm
from app.views import db

#for home url
@serverApplication.route("/")
@serverApplication.route("/home")
def home():
      return render_template("home.html")

#authenticate admin and route to '/admin'
@serverApplication.route("/adminlogin", methods=['GET','POST'])
def adminlogin():
      form = AdminForm()

      if form.validate_on_submit():
            adminid = form.adminID.data ; password = form.password.data
            if len(list(db.admin.find({'$and':[{'id':adminid}, {'password':password}]}))) == 0:
                  print('No such admin')
            else:
                  return render_template('home.html',status = 1)

      return render_template('login.html', form = form)
#------------------------------------------------------------------------------------------------------