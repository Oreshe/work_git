#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Використання: $0 <коренева_директорія_проекту>"
    exit 1
fi

PROJECT_DIR="$1"

if [[ ! -d "$PROJECT_DIR" ]]; then
    echo "Помилка: Директорія '$PROJECT_DIR' не існує!"
    exit 1
fi

if [[ ! -f "$PROJECT_DIR/.clang-format" ]]; then
    echo "Помилка: Файл .clang-format відсутній у '$PROJECT_DIR'!"
    exit 1
fi

find "$PROJECT_DIR" \( -name "*.c" -o -name "*.h" \) -exec clang-format-17 -i {} +
