validate_payment = {
    "type" : "object",
    "properties": {
        "signature" : {"type" : "string"},
        "transaction_id" : {"type" : "number"},
        "user_id" : {"type" : "number"},
        "bill_id" : {"type" : "number"},
        "amount" : {"type" : "number"},
    },
    "required": [ "signature", "transaction_id", "user_id", "bill_id", "amount" ]
}

validate_product = {
    "type" : "object",
    "properties": {
        "id" : {"type" : "number"},
        "name" : {"type" : "string"},
        "definition" : {"type" : "string"},
        "price" : {"type" : "number"},
    },
    "required": [ "id" ]
}

validate_user = {
    "type": "object",
    "properties": {
        "login": {"type" : "string"},
        "password":  {"type" : "string"},
    },
    "required": [ "login", "password" ]
}

validate_buy= {
    "type" : "object",
    "properties": {
        "product_id" : {"type" : "number"},
        "account_id" : {"type" : "number"},
    },
    "required": [ "product_id", "account_id" ]
}

validate_user_accounts = {
    "type" : "object",
    "properties": {
        "user_id" : {"type" : "number"}
    },
    "required": [ "product_id" ]
}

validate_user_transactions = {
    "type" : "object",
    "properties": {
        "user_id" : {"type" : "number"}
    },
    "required": [ "product_id" ]
}

validate_activate_user = {
    "type" : "object",
    "properties": {
        "id" : {"type" : "number"},
        "active" : {"type" : "number"},
    },
    "required": [ "product_id", "account_id" ]
}