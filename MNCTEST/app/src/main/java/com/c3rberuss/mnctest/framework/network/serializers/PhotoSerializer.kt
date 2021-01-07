package com.c3rberuss.mnctest.framework.network.serializers


import com.squareup.moshi.Json

data class PhotoSerializer(
    var id: String,
    var width: Int,
    var height: Int,
    @field:Json(name = "blur_hash")
    var blurHash: String,
    var urls: UrlsSerializer,
    var likes: Int,
    var user: UserSerializer,
    var views: Int,
    var downloads: Int
)