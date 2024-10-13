# Dockerfile
# ベースイメージとしてPython 3.7を使用
FROM python:3.7

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# ネットワーク関連ツールをインストール
RUN apt-get update && apt-get install -y netcat

# 依存関係をコピーしてインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# エントリーポイントスクリプトをコピーして実行権限を付与
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# プロジェクト全体をコピー
COPY . .

# ポートを開放
EXPOSE 8000

# エントリーポイントを設定
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
