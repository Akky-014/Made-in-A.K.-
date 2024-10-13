@echo off
SETLOCAL EnableDelayedExpansion

REM ログファイルを設定
set LOGFILE=batch_log.txt
echo Batch process started > %LOGFILE%

REM PostgreSQLデータベースの作成
echo Checking and creating PostgreSQL database if it does not exist...
set PGPASSWORD=postgres
"C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -lqt | findstr /I "django_db" >nul
IF ERRORLEVEL 1 (
    echo "django_db" does not exist, creating database... >> %LOGFILE%
    "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -c "CREATE DATABASE django_db;" >> %LOGFILE% 2>&1
    IF ERRORLEVEL 1 (
        echo Error creating PostgreSQL database >> %LOGFILE%
        echo PostgreSQL database creation failed!
        exit /b
    )
) ELSE (
    echo "django_db" already exists, skipping creation. >> %LOGFILE%
)

REM 必要な環境変数を設定
echo Setting environment variables...
set DB_NAME=django_db
set DB_USER=postgres
set DB_PASSWORD=postgres
set DB_HOST=localhost

REM Python仮想環境の作成
IF NOT EXIST "venv" (
    echo Creating virtual environment...
    echo Creating virtual environment... >> %LOGFILE%
    python -m venv venv
    IF ERRORLEVEL 1 (
        echo Error creating virtual environment >> %LOGFILE%
        echo Virtual environment creation failed!
        exit /b
    )
)

REM 仮想環境の有効化
echo Activating virtual environment...
echo Activating virtual environment... >> %LOGFILE%
call venv\Scripts\activate
IF ERRORLEVEL 1 (
    echo Error activating virtual environment >> %LOGFILE%
    echo Virtual environment activation failed!
    exit /b
)

REM 依存パッケージのインストール
echo Installing dependencies...
echo Installing dependencies... >> %LOGFILE%
pip install -r requirements.txt
IF ERRORLEVEL 1 (
    echo Error installing dependencies >> %LOGFILE%
    echo Dependency installation failed!
    exit /b
)

REM Djangoマイグレーションとスーパーユーザーの作成
echo Running migrations...
echo Running migrations... >> %LOGFILE%
python C:\workspace\manualToolSample\manualToolSample\manage.py makemigrations
python C:\workspace\manualToolSample\manualToolSample\manage.py migrate
IF ERRORLEVEL 1 (
    echo Error during migrations >> %LOGFILE%
    echo Migrations failed!
    exit /b
)

REM insert_data.pyの実行
echo Running insert_data.py...
python C:\workspace\manualToolSample\manualToolSample\insert_data.py
IF ERRORLEVEL 1 (
    echo Error running insert_data.py >> %LOGFILE%
    echo insert_data.py failed!
    exit /b
)

REM スーパーユーザーの自動作成
echo Creating superuser if not exists...
echo Creating superuser if not exists... >> %LOGFILE%
python C:\workspace\manualToolSample\manualToolSample\manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'adminpassword') if not User.objects.filter(username='admin').exists() else print('Superuser already exists')"
IF ERRORLEVEL 1 (
    echo Error creating superuser >> %LOGFILE%
    echo Superuser creation failed!
    exit /b
)

REM Django開発サーバーの起動
echo Starting Django server...
echo Starting Django server... >> %LOGFILE%
start "" http://localhost:8000  REM ブラウザを自動で開く
python C:\workspace\manualToolSample\manualToolSample\manage.py runserver 0.0.0.0:8000
IF ERRORLEVEL 1 (
    echo Error starting Django server >> %LOGFILE%
    echo Django server failed to start!
    exit /b
)

echo Batch process completed >> %LOGFILE%