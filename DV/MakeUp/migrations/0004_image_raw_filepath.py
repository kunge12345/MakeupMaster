# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0003_auto_20151107_0431'),
    ]

    operations = [
        migrations.AddField(
            model_name='image_raw',
            name='filePath',
            field=models.CharField(default=0, max_length=200),
            preserve_default=False,
        ),
    ]
