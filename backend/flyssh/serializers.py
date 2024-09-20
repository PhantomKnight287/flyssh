from rest_framework import serializers
from django.contrib.auth.models import User



class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=255)
    password = serializers.CharField(max_length=255)
    master_key = serializers.CharField(max_length=1024)

class RegisterSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=255)
    password = serializers.CharField(max_length=255)
    first_name = serializers.CharField(max_length=255)
    last_name = serializers.CharField(max_length=255)


class CreateHostSerializer(serializers.Serializer):
    hostname = serializers.CharField(max_length=255)
    label = serializers.CharField(max_length=255,required=False)
    username = serializers.CharField(max_length=255)
    password = serializers.CharField(max_length=255,required=False)
    key_id = serializers.CharField(required=False)
    master_key = serializers.CharField()


class CreateKeySerializer(serializers.Serializer):
    label = serializers.CharField(max_length=1024)
    value = serializers.CharField()
    passphrase =serializers.CharField(required=False)
    master_key = serializers.CharField()


class DecodePasswordSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    master_key = serializers.CharField()
    

class UpdateKeySerializer(CreateKeySerializer):
    id = serializers.IntegerField()

class UpdateHostSerializer(CreateHostSerializer):
    id = serializers.IntegerField()