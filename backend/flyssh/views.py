from django.http import HttpResponse, HttpRequest, JsonResponse
from django.contrib.auth import authenticate, login
from flyssh.serializers import LoginSerializer, RegisterSerializer, CreateHostSerializer, CreateKeySerializer, DecodePasswordSerializer, UpdateKeySerializer, UpdateHostSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from flyssh.models import User, Host, Key
from django.shortcuts import get_object_or_404

# Create your views here.

def index(req):
    return JsonResponse({"message": "Welcome to FlySSH, World's most shitty ssh client"})


@api_view(['POST'])
@permission_classes([])
def login(request: HttpRequest):
    serializer = LoginSerializer(data=request.data)
    if serializer.is_valid():
        user = authenticate(username=serializer.data['username'], password=serializer.data['password'])
        if user is not None:
            try:
                correct_master_key = user.verify_master_key(serializer.data['master_key'])
                if not correct_master_key:
                    return Response({"message": "Incorrect master key"}, status=status.HTTP_400_BAD_REQUEST)
            except Exception as e:
                return Response({"message": "Incorrect master key"}, status=status.HTTP_400_BAD_REQUEST)
            token, _ = Token.objects.get_or_create(user=user)
            return Response({"username": user.username, "token": token.key,"first_name":user.first_name,"last_name":user.last_name})
        else:
            return Response({"message": "Invalid username or password", }, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response({"errors": serializer.errors}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(["POST"])
@permission_classes([])
def register(request):
    serializer = RegisterSerializer(data=request.data)
    if not serializer.is_valid():
        return Response({"errors": serializer.errors}, status=400)
    oldUser = User.objects.filter(username=serializer.data["username"])
    if oldUser:
        return Response({"message": "Username is already taken"}, status=409)
    if serializer.is_valid():
        user = User.objects.create_user(
            username=serializer.data["username"], password=serializer.data["password"],
            first_name=serializer.data["first_name"], last_name=serializer.data["last_name"],
        )
        master_key = user.generate_encoded_secret()
        user.save()
        token, _ = Token.objects.get_or_create(user=user)
        return Response({"username": user.username, "token": token.key, "master_key": master_key}, status=201)
    else:
        return Response({"message": "Invalid username or password"}, status=400)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def get_profile(request):
    token = request.headers["Authorization"].split(" ")[1]
    user = Token.objects.get(key=token).user
    if not user:
        return Response({"message": "Invalid token"}, status=400)
    return Response({"username": user.username, "first_name": user.first_name, "last_name": user.last_name}, status=200)


@api_view(["POST","GET","PATCH"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def hosts(request:HttpRequest):
    if request.method == "GET":
        token = request.headers["Authorization"].split(" ")[1]
        user = Token.objects.get(key=token).user
        hosts = Host.objects.prefetch_related('key').all().filter(owner_id=user.id).values('hostname','label','username','id','password','key','key__label', 'key__value', 'key__passphrase',"key__id").order_by("-id")
        return Response(list(hosts),status=200)
    

    if request.method == "PATCH":
        body = UpdateHostSerializer(data=request.data)
        token = request.headers["Authorization"].split(" ")[1]
        user = Token.objects.get(key=token).user
        if(not body.is_valid()):
            return Response({"message": body.errors}, status=400)
           
        host = get_object_or_404(Host,id=body.data.get("id"),owner_id=user.id,)
        host.hostname = body.data.get("hostname") if body.data.get("hostname") else host.hostname
        host.label = body.data.get("label") if body.data.get("label") else host.label
        host.username = body.data.get("username") if body.data.get("username") else host.username
        if(body.data.get("password")):
            host.password = body.data.get("password")
            host.encrypt_password()

        host.save()
        return Response({"message":"Host Updated"},status=200)



    body = CreateHostSerializer(data=request.data)
    if not body.is_valid():
        return Response({"message": body.errors}, status=400)
    if not body.data.get("password", None) and not body.data.get("key_id", None):
        return Response({"message": "Please provide password or key"}, status=400)




    token = request.headers["Authorization"].split(" ")[1]
    user = Token.objects.get(key=token).user
    host =  Host(
        hostname=body.data.get("hostname"),
        username=body.data.get("username"),
        password=body.data.get("password"),
        owner_id=user.id,
        label=body.data.get("label"),
    ) 
    if (body.data.get("password", None)):
        try:
            host.encrypt_password(body.data.get("master_key"))
        except Exception as e:
            return Response({"message": "Invalid master key"}, status=status.HTTP_400_BAD_REQUEST)

        host.save()
    else:
        key_id = body.data.get("key_id")
        if not key_id:
            return Response({"message": "Please provide key id"}, status=400)
        if key_id:
            if not key_id.isdigit():
                return Response({"message": "Key id must be an integer"}, status=400)
            try:
                key = Key.objects.get(id=int(key_id))
                host.key_id = key.id
                host.save()

            except Key.DoesNotExist:
                return Response({"message": "Key with given id does not exist"}, status=404)


    return Response({"message": "Host created"}, status=201)



@api_view(["POST","GET","PATCH"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def keys(request:HttpRequest):
    if(request.method=="GET"):
        token = request.headers["Authorization"].split(" ")[1]
        user = Token.objects.get(key=token).user
        keys = Key.objects.all().filter(owner_id=user.id).values('label','id','value','passphrase').order_by("-id")
        return Response(list(keys),status=200)
    
    if request.method == "PATCH":
        token = request.headers["Authorization"].split(" ")[1]
        user = Token.objects.get(key=token).user
        body = UpdateKeySerializer(data=request.data)
        if not body.is_valid():
            return Response({"message": body.errors}, status=400)
        key = get_object_or_404(Key,id=body.data.get("id"),owner_id=user.id,)

        key.label = body.data.get("label") if body.data.get("label") else key.label
        key.value = body.data.get("value") if body.data.get("value") else key.value
        key.passphrase = body.data.get("passphrase") if body.data.get("passphrase") else key.passphrase
        if(body.data.get("value",None) is not None):
            key.encode_key(
                body.data.get("master_key")
            )
        if(body.data.get("passphrase",None) is not None):
            key.encode_passphrase(
                body.data.get("master_key")
            )
        key.save()

        return Response({"message":"Key Updated"},status=200)
        


    body = CreateKeySerializer(data=request.data)
    if not body.is_valid():
        return Response({"message": body.errors}, status=400)
    token = request.headers["Authorization"].split(" ")[1]
    user = Token.objects.get(key=token).user
    key = Key(
        label=body.data.get("label"),
        value=body.data.get("value"),
        passphrase=body.data.get("passphrase"),
        owner_id=user.id,
    )
    if(body.data.get("passphrase")):
        try:
            key.encode_passphrase(body.data.get("master_key"))
        except Exception as e:
            return Response({"message": "Invalid master key"}, status=status.HTTP_400_BAD_REQUEST)

    try:
        key.encode_key(body.data.get("master_key"))
    except Exception as e:
        return Response({"message": "Invalid master key"}, status=status.HTTP_400_BAD_REQUEST)

    key.save()

    return Response({"message": "Key created","id":key.id}, status=201)



@api_view(["POST"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def decode_password(request:HttpRequest):
    body = DecodePasswordSerializer(data=request.data)
    if not body.is_valid():
        print(body.errors)
        return Response({"message":body.errors},status=400)
    token = request.headers["Authorization"].split(" ")[1]
    user = Token.objects.get(key=token).user

    host = get_object_or_404(Host,id=body.data.get("id"),owner_id=user.id,)
    if(host.key):
        host.key.decode_value(body.data.get("master_key"))
        host.key.decode_passphrase(body.data.get("master_key"))
        return Response({"password":host.key.value,"passphrase":host.key.passphrase,"key":True})
    try:
        host.decode_password(body.data.get("master_key"));
    except Exception as e:
        return Response({"message":"Invalid Master key"},status=400)
    
    return Response({"password": host.password,"key":False}, status=200)



    
