# ベースイメージとしてPython 3.8を使用
FROM python:3.8

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# 依存関係のコピーとインストール
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションファイルをコンテナ内にコピー
COPY . .

# Djangoプロジェクトの起動
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]