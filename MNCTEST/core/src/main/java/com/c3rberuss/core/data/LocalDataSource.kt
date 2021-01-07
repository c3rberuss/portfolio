package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource

abstract class LocalDataSource{
    abstract suspend fun addToFavorites(photo: Photo) : Boolean
    abstract suspend fun removeFromFavorites(photo: Photo) : Boolean
    abstract suspend fun getAllFavoritePhotos() : Resource<List<Photo>>
}