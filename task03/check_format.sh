#!/bin/bash

XX_VER="17"
YY_VER="22"

if [ $# -ne 1 ]; then
    echo " Довідка з використання check_format.sh"
    echo "Використання: $0 <коренева_директорія_проекту>"
    echo "Приклад:     $0 ./dummy"
    exit 1
fi

PROJECT_DIR="$1"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Помилка: Директорія '$PROJECT_DIR' не існує!"
    exit 1
fi

if [ ! -f "$PROJECT_DIR/.clang-format" ]; then
    echo "Помилка: Файл .clang-format відсутній у '$PROJECT_DIR'!"
    exit 1
fi

echo "CLANG-FORMAT $XX_VER VERSION"
find "$PROJECT_DIR" \( -name "*.c" -o -name "*.h" \) -exec clang-format-$XX_VER --dry-run --Werror {} + 2>&1

echo ""
echo "CLANG-FORMAT $YY_VER VERSION"
find "$PROJECT_DIR" \( -name "*.c" -o -name "*.h" \) -exec clang-format-$YY_VER --dry-run --Werror {} + 2>&1
