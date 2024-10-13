from django.contrib.auth import get_user_model
import os

User = get_user_model()
USERNAME = os.getenv('DJANGO_SUPERUSER_USERNAME')
EMAIL = os.getenv('DJANGO_SUPERUSER_EMAIL')
PASSWORD = os.getenv('DJANGO_SUPERUSER_PASSWORD')

try:
    # スーパーユーザーが存在しない場合のみ作成
    if not User.objects.filter(username=USERNAME).exists():
        User.objects.create_superuser(USERNAME, EMAIL, PASSWORD)
        print(f"Superuser {USERNAME} created")
    else:
        print(f"Superuser {USERNAME} already exists")
except Exception as e:
    print(f"Error creating superuser: {e}")