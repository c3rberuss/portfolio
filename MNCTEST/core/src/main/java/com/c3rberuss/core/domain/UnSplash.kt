package com.c3rberuss.core.domain

open class Photo(
    open var id: String,
    open var blurHash: String,
    open var likes: Int,
    open var width: Int,
    open var height: Int,
    open var urls: Urls,
    open var user: User,
)

open class Urls(open var full: String)

open class User(
    open var username: String,
    open var name: String,
    open var profileImage: ProfileImage,
)

open class ProfileImage(open var medium: String)