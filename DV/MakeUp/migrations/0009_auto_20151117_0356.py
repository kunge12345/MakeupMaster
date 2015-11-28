# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0008_auto_20151107_2357'),
    ]

    operations = [
        migrations.AlterField(
            model_name='image_raw',
            name='file',
            field=models.FileField(upload_to=b'Image_Raw/'),
        ),
    ]
