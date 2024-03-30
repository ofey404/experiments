from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column, String, Integer
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine("sqlite:///:memory:", echo=True)

SessionFactory = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class KeyValue(Base):
    __tablename__ = 'key_value'
    id = Column(Integer, primary_key=True)
    key = Column(String, nullable=False, unique=True)
    value = Column(String, nullable=False)


Base.metadata.create_all(engine)

db = SessionFactory()

db.add(KeyValue(key='name', value='Alice'))
v = db.query(KeyValue).filter_by(key='name').first()

print(v)
