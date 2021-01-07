package com.c3rberuss.mnctest.framework.network.serializers


import com.squareup.moshi.Json

data class UserSerializer(
    var id: String,
    var username: String,
    var name: String,
    @field:Json(name = "twitter_username")
    var twitterUsername: String,
    var bio: String,
    var location: String,
    var links: LinksSerializer,
    @field:Json(name = "profile_image")
    var profileImage: ProfileImageSerializer,
    @field:Json(name = "instagram_username")
    var instagramUsername: String,
    @field:Json(name = "total_collections")
    var totalCollections: Int,
    @field:Json(name = "total_likes")
    var totalLikes: Int,
    @field:Json(name = "total_photos")
    var totalPhotos: Int,
    @field:Json(name = "accepted_tos")
    var acceptedTos: Boolean
)