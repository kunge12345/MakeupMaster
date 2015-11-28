# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0002_image_raw_option'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='image_new',
            name='filePath',
        ),
        migrations.RemoveField(
            model_name='image_raw',
            name='filePath',
        ),
        migrations.RemoveField(
            model_name='image_raw',
            name='option',
        ),
    ]
