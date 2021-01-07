package com.c3rberuss.mnctest.di

import com.c3rberuss.mnctest.framework.network.UnSplashApi
import com.c3rberuss.mnctest.framework.network.UnSplashApi.Companion.BASE_URL
import com.c3rberuss.mnctest.framework.network.UnSplashInterceptor
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.jackson.JacksonConverterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class NetworkModule {
    @Singleton
    @Provides
    fun providesUnSplashApi(): UnSplashApi {

        val logging = HttpLoggingInterceptor()
        logging.level = HttpLoggingInterceptor.Level.BODY

        val client: OkHttpClient = OkHttpClient.Builder()
            .connectTimeout(20, TimeUnit.SECONDS)
            .readTimeout(20, TimeUnit.SECONDS)
            .addInterceptor(UnSplashInterceptor())
            .addInterceptor(logging)
            .build()


        return Retrofit.Builder()
            .client(client)
            .baseUrl(BASE_URL)
            .addConverterFactory(MoshiConverterFactory.create())
            .addConverterFactory(JacksonConverterFactory.create())
            .build()
            .create(UnSplashApi::class.java)
    }
}