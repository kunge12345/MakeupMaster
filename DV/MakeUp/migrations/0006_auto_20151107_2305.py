# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0005_auto_20151107_2218'),
    ]

    operations = [
        migrations.AlterField(
            model_name='image_new',
            name='file',
            field=models.ImageField(upload_to=b'Image_New/'),
        ),
        migrations.AlterField(
            model_name='image_raw',
            name='file',
            field=models.ImageField(upload_to=b'Image_Raw/'),
        ),
    ]
