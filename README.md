# API-for-DimaTech
\
Основной функционал:
1) Функция create_user. На вход получает json с логином и паролем пользователя, пользователь создается в неактивном состоянии. Возвращает ссылку активации, после использования которой пользователь перейдет в активное состояние. Пример:\
На вход получаем JSON:\
{\
  "login": "login",\
  "password": "password"\
}\
Эндпоинт возвращает:\
{\
    "activate_link": "http://127.0.0.1:1337/activate?user_id=14&activate_hash=a423ekwl79fni0xz"
}
2) Функция activate_user. Отвечает за активацию пользователя и сохранение его статуса в базе данных.
3) Функция do_login. Отвечает за вход пользователя в приложение. Возвращает токен в Bearer формате.\
На вход получает JSON:\
{\
        "login": "login",\
        "password": "password"\
}\
Возвращает:\
{\
  "token": "token"\
}
4) Функция get_user. Отвечает за получение данных о пользователе.
5) Функция get_account. На вход получает данные описанные в схеме validate_user_accounts. Используется для получения информации обо всех счетах пользователя.\
На вход получает JSON:\
{\
  "user_id": 1\
}\
Возвращает:\
{\
  "id": 1,\
  "login": "login",\
  "active": True\
}
6) Функция get_transactions. Отвечает за получение всех транзакций согласно счету.\
На вход получает только токен в заголовке. Возвращает:\
[\
    {\
        "id": 1,\
        "transaction_timestamp": "2004-10-19 08:23:54",\
        "amount": 100,\
        "account_id": 1\
    },\
    {\
        "id": 23,\
        "transaction_timestamp": "2022-08-24 18:16:06",\
        "amount": 500,\
        "account_id": 1\
    },\
    {\
        "id": 25,\
        "transaction_timestamp": "2022-08-25 09:25:02",\
        "amount": 700,\
        "account_id": 1\
    },\
    {\
        "id": 26,\
        "transaction_timestamp": "2022-08-25 09:27:36",\
        "amount": 700,\
        "account_id": 1\
    },\
    {\
        "id": 33,\
        "transaction_timestamp": "2022-08-25 09:32:30",\
        "amount": 900,\
        "account_id": 1\
    },\
    {\
        "id": 37,\
        "transaction_timestamp": "2022-08-25 15:33:18",\
        "amount": 900,\
        "account_id": 1\
    },\
    {\
        "id": 38,\
        "transaction_timestamp": "2022-08-25 16:48:16",\
        "amount": 900,\
        "account_id": 2\
    }\
]
7) Функция get_paid. Отвечает за зачисление средст на счет с другого сервиса. На вход получает данные описаныые в схеме validate_payment.\
На вход получает JSON:\
{\
	"signature": "40272244ab18c03df06815ceba6dc7022f51cc2a",\
	"transaction_id": 38,\
	"user_id": 10,\
	"bill_id": 2,\
	"amount": 900\
}\
Возвращает:\
"Success" либо ошибку.
8) Функция buy_product. Отвечает за покупку продукта. На вход получает данные описанные в схеме validate_buy. \
На вход получает:\
Токен в заголовке и JSON:\
{\
  "product_id": 1,\
  "account_id": 1\
}\
Возвращает:\
"Success" либо ошибку.
9) Функция activate_user_by_admin. Отвечает за активацию пользователя администратором. На вход получает данные описанные в схеме validate_activate_user.\
На вход получает токен и JSON:\
{\
  "id": 1,\
  "active": True\
}\
Возвращает:\
"Activated", "Deactivated" или ошибку.
10) Функция get_product. Отвечает за получение информации обо всех товарах.\
На вход не получает ничего. \
Возвращает:\
[\
    {\
        "id": 1,\
        "name": "TV\n",\
        "definition": "Just TV",\
        "price": 1000\
    },\
    {\
        "id": 2,\
        "name": "PS5",\
        "definition": "Gaming console",\
        "price": 2000\
    },\
    {\
        "id": 4,\
        "name": "XBOX",\
        "definition": "Gaming console",\
        "price": 15000\
    }\
]
11) Функция add_product. Отвечает за добавление товара. На вход получает данные описанные в схеме validate_product.\
На вход получает токен и JSON:\
{\
  "id": 1,\
  "name": "TV",\
  "definition": "Just TV",\
  "price": 1000\
}\
Возвращает:\
"Add completed" или ошибку.
12) Функция change_product. Отвечает за изменение товара. На вход получает данные описанные в схеме validate_product.\
На вход получает токен и JSON:\
{\
  "id": 1,\
  "name": "TV",\
  "definition": "Just TV",\
  "price": 1000\
}\
Возвращает:\
"Product has been changed!" или ошибку.
13) Функция delete_product. Отвечает за удаление товара.\
На вход получает токен и JSON:\
{\
  "id": 1\
}\
Возвращает:\
"Delete complited successfuly." или ошибку.\
\
В приложении используется JWT. Все эндпоинты защищенные декораторами @protected или @is_admin должны в заголовке получать ключ Authorization в Bearer формате. \
\
В файле validate_schemes.py описаны все схемы, которые валидируются в приложении.\
\
Также в репозитории есть БД, которая использовалась для тестирвания API. Ее можно развернуть в PostgreSQL.
