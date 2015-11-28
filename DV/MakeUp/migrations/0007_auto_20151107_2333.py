# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0006_auto_20151107_2305'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='image_new',
            name='file',
        ),
        migrations.RemoveField(
            model_name='image_raw',
            name='file',
        ),
    ]
