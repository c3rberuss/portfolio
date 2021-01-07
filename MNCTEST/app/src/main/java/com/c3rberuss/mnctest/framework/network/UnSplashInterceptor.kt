package com.c3rberuss.mnctest.framework.network

import com.c3rberuss.mnctest.framework.network.UnSplashApi.Companion.CLIENT_ID
import com.c3rberuss.mnctest.framework.network.UnSplashApi.Companion.PHOTOS_PER_PAGE
import okhttp3.HttpUrl
import okhttp3.Interceptor
import okhttp3.Response

class UnSplashInterceptor : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {

        var request = chain.request()

        val url: HttpUrl = request
            .url()
            .newBuilder()
            .addQueryParameter("per_page", PHOTOS_PER_PAGE.toString())
            .build()


        request = request.newBuilder()
            .addHeader("Authorization", "Client-ID $CLIENT_ID")
            .url(url)
            .build()

        return chain.proceed(request)
    }
}