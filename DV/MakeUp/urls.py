from django.conf.urls import url

from . import views

urlpatterns = [
    #url(r'^upload/', views.upload, name='upload'),
    url(r'^list/', views.list, name = 'list'),
    #url(r'^$', views.index, name='index'),
    url(r'^(?P<image_id>[0-9]+)/$', views.detail, name='detail'),
    url(r'^(?P<image_id>[0-9]+)/choice/$', views.choice, name='choice'),
     
]


