@echo off
REM 仮想環境のディレクトリを削除
if exist "venv\" (
    echo "Deleting virtual environment..."
    rmdir /s /q venv
    echo "Virtual environment deleted."
) else (
    echo "No virtual environment found."
)

REM もしmigrationsフォルダが存在する場合、マイグレーションファイルを削除
if exist "boardapp\migrations" (
    echo "Deleting migration files..."
    rmdir /s /q boardapp\migrations
    echo "Migration files deleted."
)

REM 一時的なpycファイルを削除
echo "Deleting temporary files..."
for /r %%i in (*.pyc) do del "%%i"
for /r %%i in (__pycache__) do rmdir /s /q "%%i"
echo "Temporary files deleted."

REM データベースのリセット（オプション）
REM ローカルのPostgreSQLデータベースをリセットしたい場合は、以下の行をアンコメントして適宜編集してください。
REM psql -U postgres -c "DROP DATABASE django_db;"
REM psql -U postgres -c "DROP USER django_user;"

echo "Cleanup complete."