from django.db import models

# Create your models here.
class BoardModel(models.Model):
    title = models.CharField(max_length=120)
    content = models.TextField()
    author = models.CharField(max_length=100)
    images = models.ImageField(upload_to='')
    good = models.IntegerField(null=True, blank=True, default=0)
    read = models.IntegerField(null=True, blank=True, default=0)
    readtext = models.CharField(max_length=200, null=True, blank=True, default='a')

class EventModel(models.Model):
    eventName = models.CharField(max_length=50)
    packageName = models.CharField(max_length=150, null=True, blank=True, default='-')
    componentName = models.CharField(max_length=150, null=True, blank=True, default='-')
    nodeViewId = models.CharField(max_length=150, null=True, blank=True, default='-')
    nodeAddress = models.CharField(max_length=150, null=True, blank=True, default='-')
    images = models.ImageField(upload_to='',null=True, blank=True)
    detail = models.TextField(null=True, blank=True, default='-')