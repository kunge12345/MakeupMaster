# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='image_raw',
            name='option',
            field=models.IntegerField(default=0),
        ),
    ]
