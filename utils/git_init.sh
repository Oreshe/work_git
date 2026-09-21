#!/bin/bash

# 0. Перевірка безпеки: чи не перебуваємо ми вже в Git-репозиторії

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Помилка безпеки: Поточна директорія (або її батьківська папка) вже є Git-репозиторієм!"
    echo "Не можна створювати конфіг або новий проект всередині існуючого репозиторію."
    exit 1
fi

CONFIG_FILE=".git_myconfig"


# 1. Перевірка наявності конфігураційного файлу

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Помилка: Файл конфігурації '$CONFIG_FILE' не знайдено в поточній директорії!"
    read -p "Бажаєте створити його зараз? (y/n): " choice
    case "$choice" in 
        y|Y )
            read -p "Введіть ваше ім'я (user.name): " input_name
            read -p "Введіть ваш email (user.email): " input_email
            read -p "Введіть гілку за замовчуванням (наприклад, main): " input_branch
            
            echo "USER_NAME=\"$input_name\"" > "$CONFIG_FILE"
            echo "USER_EMAIL=\"$input_email\"" >> "$CONFIG_FILE"
            echo "USER_BRANCH=\"${input_branch:-main}\"" >> "$CONFIG_FILE"
            echo "Файл '$CONFIG_FILE' успішно створено!"
            ;;
        * )
            echo "Роботу завершено. Для роботи скрипта потрібен файл конфігурації."
            exit 1
            ;;
    esac
fi

source "$CONFIG_FILE"


# 2. Перевірка аргументів

f [ $# -eq 0 ]; then
    echo " Довідка з використання git_init.sh"
    echo "Використання:"
    echo "  $0 <назва_папки>                   - створити проект та ініціалізувати локальний Git"
    echo "  $0 <назва_папки> <посилання_remote> - створити проект, ініціалізувати Git та підключити remote"
    echo ""
    echo "Поточні налаштування з $CONFIG_FILE:"
    echo "  User Name:   $USER_NAME"
    echo "  User Email:  $USER_EMAIL"
    echo "  Default Br:  $USER_BRANCH"
    exit 0
fi

if [ $# -gt 2 ]; then
    echo "Помилка: Некоректна кількість параметрів ($#)."
    echo "Запустіть '$0' без параметрів для перегляду довідки."
    exit 1
fi

PROJECT_DIR="$1"
REMOTE_URL="$2"

setup_git_repo() {
    local dir="$1"
    cd "$dir" || exit 1
    
    if [ ! -d ".git" ]; then
        git init -b "${USER_BRANCH:-main}"
        git config --local user.name "$USER_NAME"
        git config --local user.email "$USER_EMAIL"
        git config --local init.defaultBranch "${USER_BRANCH:-main}"
        
        if [ ! -f "README.md" ]; then
            echo "# $dir" > README.md
            echo "Проект створено за допомогою автоматичного скрипта." >> README.md
        fi
        echo "Локальний Git-репозиторій налаштовано у '$dir'."
    else
        echo "В директорії '$dir' вже існує Git-репозиторій."
    fi

    if [ -n "$REMOTE_URL" ]; then
        if git remote | grep -q "^origin$"; then
            echo "Remote 'origin' вже існує в цьому репозиторії."
        else
            git remote add origin "$REMOTE_URL"
            echo "Удалений репозиторій '$REMOTE_URL' додано як 'origin'."
        fi
    fi
    cd ..
}

if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
    setup_git_repo "$PROJECT_DIR"
elif [ -z "$(ls -A "$PROJECT_DIR")" ]; then
    setup_git_repo "$PROJECT_DIR"
else
    echo "Помилка: Директорія '$PROJECT_DIR' існує і містить файли!"
    exit 1
fi

