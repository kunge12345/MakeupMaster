# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MakeUp', '0007_auto_20151107_2333'),
    ]

    operations = [
        migrations.AddField(
            model_name='image_new',
            name='file',
            field=models.ImageField(default=0, upload_to=b'Image_New/'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='image_raw',
            name='file',
            field=models.ImageField(default=0, upload_to=b'Image_Raw/'),
            preserve_default=False,
        ),
    ]
