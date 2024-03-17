from sqlalchemy import Column, Integer, String, Float, Text, DateTime
from database import Base

class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    description = Column(String)
    rating = Column(Float)
    youtube_trailer = Column(Text)
    download_link = Column(Text)
    cover_photo = Column(Text)
    category = Column(String)
