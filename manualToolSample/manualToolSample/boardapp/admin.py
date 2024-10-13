from django.contrib import admin
from .models import BoardModel, EventModel

# Register your models here.

admin.site.register(BoardModel)
admin.site.register(EventModel)