from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from config import CONFIG

engine = create_engine(CONFIG.db_url, echo=True)

Base = declarative_base()

SessionFactory = sessionmaker(autocommit=False, autoflush=False, bind=engine)
