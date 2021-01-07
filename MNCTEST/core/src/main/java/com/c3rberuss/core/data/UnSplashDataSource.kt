package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.User

abstract class UnSplashDataSource{
    abstract suspend fun fetchPhotos(page: Int) : Resource<List<Photo>>
    abstract suspend fun fetchPhotoDetail(photoId: String) : Resource<Photo>
    abstract suspend fun fetchUserProfile(username: String): Resource<User>
    abstract suspend fun fetchUserPhotos(username: String): Resource<List<Photo>>
    abstract suspend fun fetchUserCollection(username: String): Resource<List<Photo>>
}