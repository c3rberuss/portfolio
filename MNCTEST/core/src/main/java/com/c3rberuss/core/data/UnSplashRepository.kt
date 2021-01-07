package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.User

class UnSplashRepository(
    private val remoteDataSource: UnSplashDataSource,
    private val localDataSource: LocalDataSource
) {

    // Remote operations
    suspend fun fetchPhotos(page: Int): Resource<List<Photo>> = remoteDataSource.fetchPhotos(page)
    suspend fun fetchPhotoDetail(photoId: String): Resource<Photo> = remoteDataSource.fetchPhotoDetail(photoId)
    suspend fun fetchUserProfile(username: String): Resource<User> = remoteDataSource.fetchUserProfile(username)

    // Local operations
    suspend fun addFavorite(photo: Photo) : Boolean = localDataSource.addToFavorites(photo)
    suspend fun removeFavorite(photo: Photo) : Boolean = localDataSource.removeFromFavorites(photo)
    suspend fun getAllFavoritePhotos() : Resource<List<Photo>> = localDataSource.getAllFavoritePhotos()

}