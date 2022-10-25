from sanic import Sanic
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from contextvars import ContextVar
from sqlalchemy.orm import sessionmaker
from sqlalchemy import delete, select, delete
from sanic.response import json
from sanic.exceptions import SanicException
from models import Account, Product, Transaction, User
from simple_bcrypt import Bcrypt
import random
import string
import jwt
from sanic import Blueprint, text
from auth import protected, get_token_data, is_admin
from Crypto.Hash import SHA1
import datetime
from jsonschema import validate
from auth import get_token_data
from functools import wraps
from validate_schemes import validate_payment, validate_product, validate_user, validate_buy, validate_user_accounts, validate_user_transactions, validate_activate_user

_base_model_session_ctx = ContextVar("session")
app = Sanic(name="TestApp")
bcrypt = Bcrypt(app)
app.config.SECRET = "KEEP_IT_SECRET_KEEP_IT_SAFE"

bind = create_async_engine(
    "postgresql+asyncpg://postgres:postgres@127.0.0.1/postgres",
    echo=True
)


@app.middleware("request")
async def inject_session(request):
    request.ctx.session = sessionmaker(bind, AsyncSession, expire_on_commit=False)()
    request.ctx.session_ctx_token = _base_model_session_ctx.set(request.ctx.session)


@app.middleware("response")
async def close_session(request, response):
    if hasattr(request.ctx, "session_ctx_token"):
        _base_model_session_ctx.reset(request.ctx.session_ctx_token)
        await request.ctx.session.close()

#Function to create user
@app.post("/user")
async def create_user(request):
    session = request.ctx.session
    try:
        validate(instance=request.json, schema=validate_user)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        async with session.begin():
            activate_hash = ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(16))
            user = User(login = request.json['login'], password = bcrypt.generate_password_hash(request.json['password']).decode('utf-8'),
            activate_hash = activate_hash, active=False)
            session.add_all([user])
            session.flush()
            session.refresh(user)
        activate_link = f"{request.scheme}://{request.host}/activate?user_id={user.id}&activate_hash={activate_hash}"
        return json({"activate_link": activate_link})

#Function to activate account by user when register
@app.get("/activate")
async def activate_user(request):
    session = request.ctx.session
    async with session.begin():
        stmt = select(User).where(User.id == int(request.args["user_id"][0]))
        result = await session.execute(stmt)
        user = result.scalar()
        if not user:
            raise SanicException("Something went wrong.", status_code=403)
        if user.activate_hash == request.args["activate_hash"][0]:
            user.active = True
            return json({'status': 'Success'})
        else:
            raise SanicException("Something went wrong.", status_code=403)


login = Blueprint("login", url_prefix="/login")

#Function for login user
@login.post("/")
async def do_login(request):
    session = request.ctx.session
    try:
        validate(instance=request.json, schema=validate_user)
    except:
        raise SanicException("Incorrect JSON.", status_code=405)
    else:
        async with session.begin():
            stmt = select(User).where(User.login == str(request.json["login"]))
            result = await session.execute(stmt)
            user = result.scalar()
            if not user:
                raise SanicException("Incorrect user.", status_code=403)
            if bcrypt.check_password_hash(user.password, request.json["password"]):
                token = jwt.encode({'user': user.id}, request.app.config.SECRET)
                return json({"token": token})
            else:
                raise SanicException("Incorrect password.", status_code=403)

#Function to get user
@app.get("/user/<pk:int>")
async def get_user(request):
    session = request.ctx.session
    async with session.begin():
        user = select(User)
        user = await session.execute(user)
        user = user.scalar()
    if not user:
        return json({})
    return json(user.to_dict())



#Function to get user accounts
@app.get("/user/accounts")
@protected
async def get_account(request):
    try:
        validate(instance=request.json, schema=validate_user_accounts)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        session = request.ctx.session
        data = get_token_data(request)
        user_id = data['user_id']
        async with session.begin():
            stmt = select(Account).where(Account.user_id == user_id)
            result = await session.execute(stmt)
            account = result.scalars()
        if not account:
            return json()
        result_account = []
        for a in account:
            result_account.append(a.to_dict())
        return json(result_account)

#Function to get all transaction by user
@app.get("/user/accounts/transactions")
@protected
async def get_transactions(request):
    session = request.ctx.session
    data = get_token_data(request)
    user_id = data['user']
    async with session.begin():
        stmt = select(Transaction).join(Account, Transaction.account_id == Account.account_id).where(Account.user_id == user_id)
        result = await session.execute(stmt)
        result_tr_acc_id = result.scalars()
    if not result_tr_acc_id:
        return json()
    else:
        result_json = []
        for a in result_tr_acc_id:
            result_json.append(a.to_dict())
        return json(result_json)

#Function to transaction to user
@app.post("/payment/webhook")
async def get_paid(request):
    try:
        validate(instance=request.json, schema=validate_payment)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        session = request.ctx.session
        json1 = request.json
        signature = SHA1.new(f'{app.config.SECRET}:{json1["transaction_id"]}:{json1["user_id"]}:{json1["bill_id"]}:{json1["amount"]}'.encode())\
    .hexdigest()
        if signature == json1["signature"]:
            async with session.begin():
                transaction_id = select(Transaction).where(request.json["transaction_id"] == Transaction.id)
                user_id = select(User).where(request.json["user_id"] == User.id)
                acc = Account(account_id = request.json["bill_id"], user_id = request.json["user_id"], balance = 0)
                bill = select(Account).where(json1["bill_id"] == Account.account_id)
                result = await session.execute(bill)
                acc = result.scalar()
                if not acc:
                    acc = Account(account_id = request.json["bill_id"], balance = 0, user_id = request.json["user_id"])
                    session.add_all([acc])
                    session.flush()
                    session.refresh(acc)
                get_tr_id = await session.execute(transaction_id)
                get_user = await session.execute(user_id)
                result_get_user = get_user.scalar()
                if not result_get_user:
                    raise SanicException("User doesn't exist.", status_code=404)
                res_tr_id = get_tr_id.scalar()
                if res_tr_id:
                    raise SanicException("This transaction already exists.", status_code=403)
                acc.balance += request.json["amount"]
                session.add_all([acc])
                transaction = Transaction(id = request.json["transaction_id"],
                transaction_timestamp = datetime.datetime.now(),
                amount = request.json["amount"],
                account_id = request.json["bill_id"])
                session.add_all([transaction])
                return text("Success")  
        else:
            raise SanicException("Signatures dont match.", status_code=403)

#Function to buy product
@app.post("/user/accounts/buy")
@protected
async def buy_product(request):
    session = request.ctx.session
    token_data = get_token_data(request)
    try:
        validate(instance=request.json, schema=validate_buy)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        async with session.begin():
            acc = select(Account).where(Account.user_id == token_data["user"]).where(Account.account_id == request.json["account_id"])
            product = select(Product).where(Product.id == request.json["product_id"])
            product = await session.execute(product)
            product = product.scalar()
            acc = await session.execute(acc)
            acc = acc.scalar()
        if not product or not product.price:
            raise SanicException("Product doesn't exists.", status_code=403)
        if not acc:
            raise SanicException("Account isn't yours.", status_code=403)
        if acc.balance > product.price:
            async with session.begin():
                acc.balance -= product.price
                session.add_all([acc])
                session.flush()
                session.refresh(acc)
        else:
            raise SanicException("Need more gold.", status_code=403)
        return text("Success")

#Function to activate user by admin
@app.post("/activare-user")
async def activate_user_by_admin(request):
    try:
        validate(instance=request.json, schema=validate_activate_user)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        session = request.ctx.session
        async with session.begin():
            user = select(User).where(User.id == request.json["id"])
            user  = await session.execute(user)
            user = user.scalar()
        if not user:
            raise SanicException("User doesn't exist.", status_code=403)
        if request.json["status"] == "activate":
            async with session.begin():
                setattr(user, "active", True)
            return text("Activated")
        if request.json["status"] == "deactivate":
            async with session.begin():
                setattr(user, "active", False)
            return text("Deactivated")

#Product section
#Function to get all products
@app.get("/product")
async def get_product(request):
    session = request.ctx.session
    async with session.begin():
        products = select(Product)
        products = await session.execute(products)
        products = products.scalars()
    all_products = []
    for p in products:
        all_products.append(p.to_dict())
    return json(all_products)

#function to add product
@app.post("/product")
@is_admin
async def add_product(request):
    session = request.ctx.session
    try:
        validate(instance=request.json, schema=validate_product)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        async with session.begin():
            product_id = select(Product).where(Product.id == request.json["id"])
            product_id = await session.execute(product_id)
            product_id = product_id.scalar()
            if product_id:
                raise SanicException("Product already exists with this id.", status_code=403)
            if not product_id:
                product = Product(id  = request.json["id"],
                name  = request.json["name"],
                definition = request.json["definition"],
                price = request.json["price"])
                session.add_all([product])
                session.flush()
                session.refresh(product)
            return text("Add complited.")

#Function to change product
@app.put("/product")
@is_admin
async def change_product(request):
    session = request.ctx.session
    try:
        validate(instance=request.json, schema=validate_product)
    except:
        raise SanicException("Incorrect JSON.", status_code=403)
    else:
        async with session.begin():
            product = select(Product).where(Product.id == request.json["id"])
            product = await session.execute(product)
            product = product.scalar()
            if not product:
                raise SanicException("Product doesn't exist.", status_code=403)
            setattr(product, "name", request.json["name"])
            setattr(product, "definition", request.json["definition"])
            setattr(product, "price", request.json["price"])
        return text("Product has been changed!")

#Function to delete product
@app.delete("/product")
@is_admin
async def delete_product(request):
    session = request.ctx.session
    async with session.begin():
        try:
            de = delete(Product).where(Product.id == request.json["id"])
            result = await session.execute(de)
            result.scalar()
        except Exception as e:
            raise SanicException("No product to delete.", status_code=404)
        else:
            return text("Delete complited successfuly.")

app.blueprint(login)
app.run(host='0.0.0.0', port=1337, access_log=False)
