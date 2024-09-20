
from django.db import models
from django.contrib.auth.models import AbstractUser
import base64
from cryptography.fernet import Fernet

# Create your models here.

class User(AbstractUser):
    avatar = models.ImageField(upload_to='avatars/',blank=True)
    encoded_secret = models.BinaryField(blank=False)

    def __str__(self):
        return self.username

    def generate_encoded_secret(self):
        # Generate a key for AES encryption
        aes_key = Fernet.generate_key()

        # Encrypt the secret using AES
        cipher = Fernet(aes_key)
        encrypted_secret = cipher.encrypt(self.username.encode())

        # Store the encrypted secret in the encoded_secret field
        self.encoded_secret = encrypted_secret

        # Store the AES key for future verification
        return aes_key

    def verify_master_key(self, key):
        # Decrypt the encoded secret using the stored AES key
        cipher = Fernet(key)
        decrypted_secret = cipher.decrypt(self.encoded_secret).decode()

        # Compare the decrypted secret with the provided decoded secret
        return decrypted_secret == self.username


class Host(models.Model):
    hostname = models.CharField(max_length = 1024)
    label = models.CharField(max_length = 255,blank=True,null=True)
    username = models.CharField(max_length = 1024)
    password = models.TextField(blank = True, null = True)
    owner = models.ForeignKey(User,on_delete=models.CASCADE,blank=False,null=True,)
    key = models.ForeignKey('Key', on_delete=models.SET_NULL, blank=True, null=True, related_name='host')


    def encrypt_password(self,key,):
        self.password = Fernet(key).encrypt(self.password.encode())

    def decode_password(self,key:str):
        f = Fernet(key)
        self.password = f.decrypt(self.password.replace("b'","").replace("'","").encode())

    def __str__(self):
        return f"{self.username}@{self.hostname}" if self.label is None else f"{self.username}@{self.hostname} {self.label}"


class Key(models.Model):
    label = models.CharField(max_length = 1024)
    value = models.TextField()
    passphrase = models.TextField(blank=True,null=True)
    owner = models.ForeignKey(User,on_delete=models.CASCADE,blank=False,null=True,)
    hosts = models.ManyToManyField(Host, related_name='keys')

    def encode_key(self,key):
        cipher = Fernet(key)
        self.value = cipher.encrypt(self.value.encode())

    def encode_passphrase(self,key):
        cipher = Fernet(key)
        self.passphrase = cipher.encrypt(self.passphrase.encode())

    def decode_value(self,key:str):
            f = Fernet(key)
            self.value = f.decrypt(self.value.replace("b'","").replace("'","").encode())
    
    def decode_passphrase(self,key:str):
            f = Fernet(key)
            self.passphrase = f.decrypt(self.passphrase.replace("b'","").replace("'","").encode())

    def __str__(self):
        return self.label

