from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo

class AdminForm(FlaskForm):
      adminID = StringField('Admin ID', validators=[DataRequired()])
      password = PasswordField('Password', validators=[DataRequired()])
      login = SubmitField('Login as Admin')

class RegistrationForm(FlaskForm):
    employeename = StringField('Employee Name',
                           validators=[DataRequired(), Length(min=2, max=20)])
    state = StringField('State',
                           validators=[DataRequired(), Length(min=2, max=20)])
    district = StringField('District',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=40)])

    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password',
                                     validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Sign Up')


class LoginForm(FlaskForm):
     username = StringField('Username',validators=[DataRequired()])
     password = PasswordField('Password', validators=[DataRequired()])
     remember = BooleanField('Remember Me')
     submit = SubmitField('Login')