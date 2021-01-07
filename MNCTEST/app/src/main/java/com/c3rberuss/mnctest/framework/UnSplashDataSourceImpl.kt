package com.c3rberuss.mnctest.framework

import android.util.Log
import com.c3rberuss.core.data.UnSplashDataSource
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.User
import com.c3rberuss.mnctest.framework.network.UnSplashApi
import com.c3rberuss.mnctest.framework.network.serializers.PhotoSerializer
import com.c3rberuss.mnctest.framework.network.serializers.UserSerializer
import com.c3rberuss.mnctest.utils.DataClassMapper
import retrofit2.Response
import javax.inject.Inject

class UnSplashDataSourceImpl @Inject constructor(
    private val api: UnSplashApi,
    private val photoMapper: DataClassMapper<PhotoSerializer, Photo>
) :
    UnSplashDataSource() {


    override suspend fun fetchPhotos(page: Int): Resource<List<Photo>> {
        try {
            val response: Response<List<PhotoSerializer>> = api.fetchPhotos(page)

            if (response.code() == 200) {
                response.body()?.let {
                    val photos: List<Photo> = it.map(photoMapper)
                    return Resource.Success(photos)
                }
            }

            return Resource.Failed(Exception("Unknown exception"))

        } catch (e: Exception) {
            Log.e("FETCH PHOTOS", e.message!!)
            return Resource.Failed(e)
        }
    }

    override suspend fun fetchPhotoDetail(photoId: String): Resource<Photo> {
        try {
            val response: Response<PhotoSerializer> = api.fetchPhotoDetail(photoId).execute()

            if (response.code() == 200) {
                response.body()?.let {
                    //return Resource.Success(it)
                    return Resource.Failed(Exception("Unknown exception"))
                }
            }

            return Resource.Failed(Exception("Unknown exception"))

        } catch (e: Exception) {
            return Resource.Failed(e)
        }
    }

    override suspend fun fetchUserProfile(username: String): Resource<User> {
        try {
            val response: Response<UserSerializer> = api.fetchUserProfile(username).execute()

            if (response.code() == 200) {
                response.body()?.let {
                    //return Resource.Success(it)
                    return Resource.Failed(Exception("Unknown exception"))
                }
            }

            return Resource.Failed(Exception("Unknown exception"))

        } catch (e: Exception) {
            return Resource.Failed(e)
        }
    }

    override suspend fun fetchUserPhotos(username: String): Resource<List<Photo>> {
        TODO("Not yet implemented")
    }

    override suspend fun fetchUserCollection(username: String): Resource<List<Photo>> {
        TODO("Not yet implemented")
    }
}