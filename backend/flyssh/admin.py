from django.contrib import admin
from .models import User,Key,Host
from django.contrib.auth.admin import UserAdmin

admin.site.register(User,UserAdmin)
admin.site.register(Key)
admin.site.register(Host)