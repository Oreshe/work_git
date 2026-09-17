#!/bin/bash

CONFIG_FILE=".git_myconfig"


# 1. Перевірка наявності конфігураційного файлу

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Помилка: Файл конфігурації '$CONFIG_FILE' не знайдено в поточній директорії!"
    read -p "Бажаєте створити його зараз? (y/n): " choice
    case "$choice" in 
        y|Y )
            read -p "Введіть ваше имя (user.name): " input_name
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

# Завантажуємо змінні з файлу конфігурації
source "$CONFIG_FILE"


# 2. Перевірка кількості аргументів


# Без параметрів — вивід довідки
if [ $# -eq 0 ]; then
    echo "===================================================="
    echo " Довідка з використання git_init.sh"
    echo "===================================================="
    echo "Використання:"
    echo "  $0 <назва_папки>                   - створити проект та ініціалізувати локальний Git"
    echo "  $0 <назва_папки> <посилання_remote> - створити проект, ініціалізувати Git та підключити remote"
    echo ""
    echo "Поточні налаштування з $CONFIG_FILE:"
    echo "  User Name:   $USER_NAME"
    echo "  User Email:  $USER_EMAIL"
    echo "  Default Br:  $USER_BRANCH"
    echo "===================================================="
    exit 0
fi

# Більше 2 параметрів — помилка
if [ $# -gt 2 ]; then
    echo "Помилка: Некоректна кількість параметрів ($#)."
    echo "Запустіть '$0' без параметрів для перегляду довідки."
    exit 1
fi

PROJECT_DIR="$1"
REMOTE_URL="$2"

# Перевірка: чи не є поточна директорія вже Git-репозиторієм при спробі створити новий
if [ -d ".git" ]; then
    echo "Помилка безпеки: Поточна директорія вже є Git-репозиторієм!"
    exit 1
fi

# Функція ініціалізації та налаштування Git у папці
setup_git_repo() {
    local dir="$1"
    
    cd "$dir" || exit 1
    
    # Якщо Git ще не ініціалізовано
    if [ ! -d ".git" ]; then
        git init -b "${USER_BRANCH:-main}"
        git config --local user.name "$USER_NAME"
        git config --local user.email "$USER_EMAIL"
        git config --local init.defaultBranch "${USER_BRANCH:-main}"
        
        # Створюємо README.md, якщо його немає
        if [ ! -f "README.md" ]; then
            echo "# $dir" > README.md
            echo "Проект створено за допомогою автоматичного скрипта." >> README.md
        fi
        echo "Локальний Git-репозиторій налаштовано у '$dir'."
    else
        echo "В директорії '$dir' вже існує Git-репозиторий."
    fi

    # Додавання remote, якщо він переданий у 2-му параметрі
    if [ -n "$REMOTE_URL" ]; then
        if git remote | grep -q "^origin$"; then
            echo "Remote 'origin' вже існує в цьому репозиторії."
        else
            git remote add origin "$REMOTE_URL"
            echo "Удалений репозиторий '$REMOTE_URL' додано як 'origin'."
        fi
    fi
    
    cd ..
}


# 3. Обробка 1 параметра (Тільки ім'я директорії)

if [ $# -eq 1 ]; then
    if [ ! -d "$PROJECT_DIR" ]; then
        mkdir -p "$PROJECT_DIR"
        setup_git_repo "$PROJECT_DIR"
    elif [ -z "$(ls -A "$PROJECT_DIR")" ]; then
        # Папка існує і порожня
        setup_git_repo "$PROJECT_DIR"
    else
        # Папка існує і НЕ порожня
        if [ -d "$PROJECT_DIR/.git" ]; then
            echo "Інформація: Директорія '$PROJECT_DIR' вже існує і містить Git-репозиторій."
        else
            echo "Помилка: Директорія '$PROJECT_DIR' існує і містить файли, але не є Git-репозиторієм!"
            exit 1
        fi
    fi
fi


# 4. Обробка 2 параметрів (Директорія + Remote URL)

if [ $# -eq 2 ]; then
    if [ ! -d "$PROJECT_DIR" ]; then
        mkdir -p "$PROJECT_DIR"
        setup_git_repo "$PROJECT_DIR"
    elif [ -z "$(ls -A "$PROJECT_DIR")" ]; then
        # Папка існує і порожня
        setup_git_repo "$PROJECT_DIR"
    elif [ -d "$PROJECT_DIR/.git" ]; then
        # Папка існує і там є Git
        setup_git_repo "$PROJECT_DIR"
    else
        # Папка існує, містить файли, але не є Git
        echo "Помилка: Директорія '$PROJECT_DIR' існує і містить файли, але не є Git-репозиторієм!"
        exit 1
    fi
fi
