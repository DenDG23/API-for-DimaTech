from functools import wraps
import jwt
from sanic import text
from models import User, Role
from sqlalchemy import select
from sqlalchemy.orm import sessionmaker, selectinload
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sanic.exceptions import SanicException

def check_token(request):
    if not request.token:
        return False

    try:
        jwt.decode(
            request.token, request.app.config.SECRET, algorithms=["HS256"]
        )
    except jwt.exceptions.InvalidTokenError:
        return False
    else:
        return True


def get_token_data(request):
    if not request.token:
        return {}

    try:
        return jwt.decode(
            request.token, request.app.config.SECRET, algorithms=["HS256"]
        )
    except jwt.exceptions.InvalidTokenError:
        return {}


def protected(wrapped):
    def decorator(f):
        @wraps(f)
        async def decorated_function(request, *args, **kwargs):
            is_authenticated = check_token(request)

            if is_authenticated:
                response = await f(request, *args, **kwargs)
                return response
            else:
                return text("You are unauthorized.", 401)

        return decorated_function

    return decorator(wrapped)


def is_admin(wrapped):
    def decorator(f):
        @wraps(f)
        async def decorated_function(request, *args, **kwargs):
            is_authenticated = get_token_data(request)
            if is_authenticated:
                session = request.ctx.session
                async with session.begin():
                    is_admin = select(User).where(User.id == is_authenticated["user"]).options(selectinload(User.roles))
                    is_admin = await session.execute(is_admin)
                    is_admin = is_admin.scalar()
                    is_user_admin = any(role.name == "admin" for role in is_admin.roles)
                if not is_user_admin:
                    raise SanicException("Something went wrong.", status_code=403)
                response = await f(request, *args, **kwargs)
                return response
            else:
                return text("You are unauthorized.", 401)

        return decorated_function

    return decorator(wrapped)