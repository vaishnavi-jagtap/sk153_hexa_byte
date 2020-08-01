from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired

class AdminForm(FlaskForm):
      adminID = StringField('Admin ID', validators=[DataRequired()])
      password = PasswordField('Password', validators=[DataRequired()])
      login = SubmitField('Login as Admin')