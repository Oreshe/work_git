#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Використання: $0 <коренева_директорія_проекту>"
    exit 1
fi

PROJECT_DIR="$1"

if [ ! -d "$PROJECT_DIR" ] \vert{}\vert{} [ ! -f "$PROJECT_DIR/.clang-format" ]; then
    echo "Помилка: Директорія не існує або відсутній файл .clang-format!"
    exit 1
fi

find "$PROJECT_DIR" \( -name "*.c" -o -name "*.h" \) -exec clang-format-22 -i {} +
