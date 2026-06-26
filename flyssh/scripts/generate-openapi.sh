#!/bin/bash
rm -rf ../openapi
openapi-generator generate -i ../../backend/swagger.json -g dart-dio -o ../openapi --skip-validate-spec --additional-properties=pubLibrary=flyssh_api,pubName=flyssh_api,equalityCheckMethod=,serializationLibrary=json_serializable
cd ../openapi

# Update SDK version in pubspec.yaml
sed -i.bak "s/sdk: .*/sdk: '>=3.8.0 <4.0.0'/" pubspec.yaml && rm pubspec.yaml.bak

dart run build_runner build --delete-conflicting-outputs
cd ..