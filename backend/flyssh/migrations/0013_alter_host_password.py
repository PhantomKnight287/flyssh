# Generated by Django 5.0.4 on 2024-05-02 06:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('flyssh', '0012_host_key'),
    ]

    operations = [
        migrations.AlterField(
            model_name='host',
            name='password',
            field=models.TextField(blank=True, null=True),
        ),
    ]
