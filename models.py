from pickle import TRUE
from psycopg2 import DateFromTicks
from sqlalchemy import BigInteger, Column, Integer, String, ForeignKey, DateTime, Boolean, Table
from sqlalchemy.orm import declarative_base, relationship


Base = declarative_base()


users_roles = Table (
    'users_roles',
    Base.metadata,
    Column('user_id', ForeignKey('users.id'), primary_key = True),
    Column('role_id', ForeignKey('roles.id'), primary_key = True),
)


class BaseModel(Base):
    __abstract__ = TRUE


class User(Base):
    __tablename__ = 'users'
    id = Column(Integer(), primary_key= True)
    login = Column(String())
    password = Column(String())
    active = Column(Boolean())
    activate_hash = Column(String())
    accounts = relationship("Account")
    roles = relationship(
        'Role', secondary = users_roles
    )

    def to_dict(self):
        return {"id": self.id,
        "login": self.login,
        "active": self.active
        }



class Account(Base):
    __tablename__ = 'accounts'
    account_id = Column(Integer(), primary_key= True)
    balance = Column(BigInteger())
    user_id = Column(Integer, ForeignKey('users.id'))
    def to_dict(self):
        return {"account_id": self.account_id,
        "balance": self.balance
        }


class Role(Base):
    __tablename__ = 'roles'
    id = Column(Integer(), primary_key = True)
    name = Column(String())
    users = relationship(
        'User', secondary = users_roles
    )


class Product(Base):
    __tablename__ = 'products'
    id = Column(Integer(), primary_key = True)
    name = Column(String())
    definition = Column(String())
    price = Column(BigInteger())
    def to_dict(self):
        return {"id": self.id,
        "name": self.name,
        "definition": self.definition,
        "price": self.price}


class Transaction(Base):
    __tablename__ = 'transactions'
    id = Column(Integer(), primary_key = True)
    transaction_timestamp = Column(DateTime())
    amount = Column(BigInteger())
    account_id = Column(Integer())
    def to_dict(self):
        return {"id": self.id,
        "transaction_timestamp": self.transaction_timestamp.strftime("%Y-%m-%d %H:%M:%S"),
        "amount": self.amount,
        "account_id": self.account_id}