from django import forms

class UploadImageForm(forms.Form):
    name = forms.CharField(label = 'Please enter the name of new image')
    image = forms.FileField(label='Upload an image')
    