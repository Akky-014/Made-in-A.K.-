@echo off
REM 使用する Python のバージョンを指定（Python 3.7 を指定）
set PYTHON_VERSION=python3.7

REM Python 3.7のパスをシステム環境変数に設定（必要に応じてパスを変更）
set PATH=C:\Path\to\Python37;%PATH%

REM 既存の仮想環境があれば削除
if exist "venv\" (
    echo "Deleting existing virtual environment..."
    rmdir /s /q venv
    echo "Virtual environment deleted."
)

REM 仮想環境の作成
%PYTHON_VERSION% -m venv venv

REM 仮想環境のアクティベート
call venv\Scripts\activate

REM 必要なパッケージのインストール
pip install --upgrade pip
pip install -r requirements.txt

REM データベースが立ち上がっていることを確認する（10秒待機）
echo Waiting for the database to be ready...
timeout /t 10 >nul

REM マイグレーションの実行
python manage.py migrate

REM スーパーユーザーの作成
python manage.py createsuperuser --no-input --username admin --email admin@example.com

REM 開発サーバーの起動
python manage.py runserver