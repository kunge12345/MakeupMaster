from django.db import models

class Image_Raw(models.Model):
    name = models.CharField(max_length = 200)
    file = models.FileField(upload_to = "Image_Raw/")
    #option = models.IntegerField(default=0)
    
    #@classmethod
    #def create(cls, name, file):
    #    image = cls(name = name, file = "Image_Raw/" + file)
    #    image.save()
    #    return image
    

class Image_New(models.Model):
    image = models.ForeignKey(Image_Raw)
    name = models.CharField(max_length = 200)
    #filePath = models.CharField(max_length = 200)
    file = models.ImageField(upload_to = "Image_New/")

    


