from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
from datetime import datetime

from sqlalchemy.testing import db

import models
import database

app = FastAPI()

class MovieCreate(BaseModel):
    title: str
    description: str
    rating: float
    youtube_trailer: str
    download_link: str
    cover_photo: str
    category: str

class MovieUpdate(BaseModel):
    title: str = None
    description: str = None
    rating: float = None
    youtube_trailer: str = None
    download_link: str = None
    cover_photo: str = None
    category: str = None

class Movie(BaseModel):
    id: int
    title: str
    description: str
    rating: float
    youtube_trailer: str
    download_link: str
    cover_photo: str
    category: str
    date: datetime

    class Config:
        orm_mode = True

@app.post("/movies/", response_model=Movie)
async def create_movie(movie: MovieCreate):
    db = database.SessionLocal()
    movie_dict = movie.dict()
    movie_obj = models.Movie(**movie_dict)
    db.add(movie_obj)
    db.commit()
    db.refresh(movie_obj)
    return movie_obj

@app.get("/movies/", response_model=List[Movie])
async def read_movies():
    db = database.SessionLocal()
    movies = db.query(models.Movie).all()
    return movies

@app.get("/movies/{movie_id}", response_model=Movie)
async def read_movie(movie_id: int):
    db = database.SessionLocal()
    movie = db.query(models.Movie).filter(models.Movie.id == movie_id).first()
    if not movie:
        raise HTTPException(status_code=404, detail="Movie not found")
    return movie

@app.put("/movies/{movie_id}", response_model=Movie)
async def update_movie(movie_id: int, movie: MovieUpdate):
    db = database.SessionLocal()
    movie_dict = movie.dict()
    db.query(models.Movie).filter(models.Movie.id == movie_id).update(movie_dict)
    db.commit()
    updated_movie = db.query(models.Movie).filter(models.Movie.id == movie_id).first()
    return updated_movie

@app.delete("/movies/{movie_id}")
async def delete_movie(movie_id: int):
    db = database.SessionLocal()
    movie = db.query(models.Movie).filter(models.Movie.id == movie_id).first()
    if not movie:
        raise HTTPException(status_code=404, detail="Movie not found")
    db.query(models.Movie).filter(models.Movie.id == movie_id).delete()
    db.commit()
    return {"detail": "Movie deleted"}