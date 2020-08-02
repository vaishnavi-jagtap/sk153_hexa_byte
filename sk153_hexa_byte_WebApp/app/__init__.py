from flask import Flask
from flask_json import FlaskJSON
import flask_admin as admin
from config import Config
from app.views import db
from app.adminViews import creatingUserView

#Creating server object
serverApplication = Flask(__name__)
serverApplication.config.from_object(Config)

#creating admin and adding views
admin = admin.Admin(serverApplication)
UserView = creatingUserView()
admin.add_view(UserView(db.authority, 'Authority'))

from app import routes