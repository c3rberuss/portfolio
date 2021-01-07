package com.c3rberuss.mnctest.framework

import com.c3rberuss.core.data.LocalDataSource
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.mnctest.framework.db.dao.FavoritesDao
import com.c3rberuss.mnctest.framework.db.entities.PhotoEntity
import javax.inject.Inject

class LocalDataSourceImpl @Inject constructor(private val favoritesDao: FavoritesDao) : LocalDataSource() {

    override suspend fun addToFavorites(photo: Photo): Boolean {
        val photoEntity = photoToPhotoEntity(photo)
        return favoritesDao.addFavorite(photoEntity) > 0
    }

    override suspend fun removeFromFavorites(photo: Photo): Boolean {

        val result = favoritesDao.removeFavorite(photoToPhotoEntity(photo))
        return false
    }

    override suspend fun getAllFavoritePhotos(): Resource<List<Photo>> {
        return try {
            val favorites: List<Photo> = favoritesDao.getFavorites().map { it.toPhoto() }
            Resource.Success(favorites)
        }catch (e: Exception){
            Resource.Failed(e)
        }
    }

    private fun photoToPhotoEntity(photo: Photo) : PhotoEntity{
        return PhotoEntity(
            id = photo.id,
            likes = photo.likes,
            height = photo.height,
            width = photo.width,
            blurHash = photo.blurHash,
            url = photo.urls.full,
            userImage = photo.user.profileImage.medium,
            user = photo.user.username,
            userName = photo.user.username
        )
    }
}