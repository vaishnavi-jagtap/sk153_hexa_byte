from wtforms import form, fields
from flask_admin.contrib.pymongo import ModelView

def creatingUserView():
      class UserForm(form.Form):    #This form provides the template for admin to edit the database
            username = fields.StringField('Username')
            employeename = fields.StringField('EmployeeName')
            email = fields.StringField('Email')
            state = fields.StringField('State')
            district = fields.StringField('District')
            password = fields.PasswordField('Password')

      class UserView(ModelView):    #Modelviews are used to add the databases to admin page
            column_list = ('username','employeename','email','state','district') # displayed as the column headings in admin
            column_sortable_list = ('state','district')
            form = UserForm

      return UserView
