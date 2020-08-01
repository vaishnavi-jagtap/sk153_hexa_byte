from wtforms import form, fields
from flask_admin.contrib.pymongo import ModelView

def creatingUserView():
      class UserForm(form.Form):    #This form provides the template for admin to edit the database
            name = fields.StringField('Name')
            email = fields.StringField('Email')
            employeeID = fields.StringField('Employee ID')
            password = fields.PasswordField('Password')

      class UserView(ModelView):    #Modelviews are used to add the databases to admin page
            column_list = ('name','email','employeeID','password') # displayed as the column headings in admin
            column_sortable_list = ('name','email','employeeID','password')
            form = UserForm

      return UserView
