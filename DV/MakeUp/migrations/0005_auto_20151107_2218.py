# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0004_image_raw_filepath'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='image_raw',
            name='filePath',
        ),
        migrations.AddField(
            model_name='image_new',
            name='file',
            field=models.ImageField(default=b'None/none', upload_to=b'Image_New/'),
        ),
        migrations.AddField(
            model_name='image_raw',
            name='file',
            field=models.ImageField(default=b'None/none', upload_to=b'Image_Raw/'),
        ),
    ]
