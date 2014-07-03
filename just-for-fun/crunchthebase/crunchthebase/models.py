from google.appengine.ext import db

class Category:
    name = db.StringProperty(required=True)

class Education:
    external_id = db.StringProperty(required=True)
    name = db.StringProperty(required=True)

class Person:
    external_id = db.StringProperty(required=True)
    name = db.StringProperty(required=True)
    companies = db.ListProperty(db.Key)
    education = db.ReferenceProperty(Education)

class Company(db.Model):
    external_id = db.StringProperty(required=True)
    name = db.StringProperty(required=True)
    desc = db.TextProperty()
    city = db.StringProperty(required=True)
    total_founding = db.IntegerProperty()
    founded_on = db.DateTimeProperty()
    category = db.ReferenceProperty(Category)
    homepage_url = db.LinkProperty()
    is_closed = db. BooleanProperty()
    founder = db.ReferenceProperty(Person)
