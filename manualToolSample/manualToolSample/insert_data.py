# insert_data.py
import os
import django

# Django設定を読み込むために環境変数をセット
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'manualToolSample.settings')

# Djangoをセットアップ
django.setup()

from boardapp.models import EventModel

# 既存のデータを削除
EventModel.objects.all().delete()
print("Existing data deleted.")

# 挿入するデータ
events = [
    {'eventName': 'Event1', 'packageName': 'com.example.package1', 'componentName': 'Component1', 'nodeViewId': 'ViewId1', 'nodeAddress': 'Address1', 'images': 'example_image1.jpg', 'detail': 'This is a detail for Event 1'},
    {'eventName': 'Event2', 'packageName': 'com.example.package2', 'componentName': 'Component2', 'nodeViewId': 'ViewId2', 'nodeAddress': 'Address2', 'images': 'example_image2.jpg', 'detail': 'This is a detail for Event 2'},
    {'eventName': 'Event3', 'packageName': 'com.example.package3', 'componentName': 'Component3', 'nodeViewId': 'ViewId3', 'nodeAddress': 'Address3', 'images': 'example_image3.jpg', 'detail': 'This is a detail for Event 3'},
    {'eventName': 'Event4', 'packageName': 'com.example.package4', 'componentName': 'Component4', 'nodeViewId': 'ViewId4', 'nodeAddress': 'Address4', 'images': 'example_image4.jpg', 'detail': 'This is a detail for Event 4'},
    {'eventName': 'Event5', 'packageName': 'com.example.package5', 'componentName': 'Component5', 'nodeViewId': 'ViewId5', 'nodeAddress': 'Address5', 'images': 'example_image5.jpg', 'detail': 'This is a detail for Event 5'},
]

# データの挿入（すでに存在しない場合のみ）
for event in events:
    if not EventModel.objects.filter(eventName=event['eventName']).exists():
        EventModel.objects.create(**event)

print("Data inserted successfully.")