package com.c3rberuss.mnctest.framework.network

import com.c3rberuss.mnctest.framework.network.serializers.PhotoSerializer
import com.c3rberuss.mnctest.framework.network.serializers.UserSerializer
import retrofit2.Call
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface UnSplashApi {

    @GET("/photos")
    suspend fun fetchPhotos(@Query("page") page: Int) : Response<List<PhotoSerializer>>

    @GET("/photos/{photoId}")
    fun fetchPhotoDetail(@Path("photoId") photoId: String) : Call<PhotoSerializer>

    @GET("/users/{username}")
    fun fetchUserProfile(@Path("username") username: String) : Call<UserSerializer>

    companion object{
        const val BASE_URL = "https://api.unsplash.com"
        const val CLIENT_ID = "slqkYkOGFwpTTHczlVRDXrcLY6HJ-8H6KafR7ip3WGo"
        const val PHOTOS_PER_PAGE = 10
    }

}