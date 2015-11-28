# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Image_New',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=200)),
                ('filePath', models.CharField(max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Image_Raw',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=200)),
                ('filePath', models.CharField(max_length=200)),
            ],
        ),
        migrations.AddField(
            model_name='image_new',
            name='image',
            field=models.ForeignKey(to='MakeUp.Image_Raw'),
        ),
    ]
