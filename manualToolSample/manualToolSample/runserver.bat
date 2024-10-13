@echo off
REM 仮想環境のアクティベート
call venv\Scripts\activate

REM 開発サーバーの起動
python manage.py runserver