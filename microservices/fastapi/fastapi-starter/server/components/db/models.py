from sqlalchemy import Column, Integer, String

from server.components.db.connect import Base


class KeyValue(Base):
    __tablename__ = 'key_value'
    id = Column(Integer, primary_key=True)
    key = Column(String, nullable=False, unique=True)
    value = Column(String, nullable=False)
