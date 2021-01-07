package com.c3rberuss.mnctest.framework.db.entities

import androidx.room.*
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.ProfileImage
import com.c3rberuss.core.domain.Urls
import com.c3rberuss.core.domain.User

@Entity(
    tableName = "favorite_photo",
    indices = [
        Index(value = ["id"], unique = true)
    ],
)
class PhotoEntity(
    @PrimaryKey var id: String,
    var likes: Int,
    var width: Int,
    var height: Int,
    @ColumnInfo(name = "blur_hash")
    var blurHash: String,

    var url: String,
    var user: String,
    @ColumnInfo(name = "user_name")
    var userName: String,
    var userImage: String,
){

    fun toPhoto() : Photo {
        return Photo(
            id = id,
            blurHash = blurHash,
            width = width,
            height = height,
            likes = likes,
            urls = Urls(url),
            user = User(
                name = userName,
                username = userName,
                profileImage = ProfileImage(userImage)
            )
        )
    }

}

@Entity(
    tableName = "url",
    indices = [
        Index(value = ["photo_id"], unique = true)
    ]
)
class UrlsEntity(
    var full: String,
    @PrimaryKey
    @ColumnInfo(name = "photo_id")
    var photoId: String
)

@Entity(
    tableName = "user",
    indices = [
        Index(value = ["username"], unique = true)
    ]
)
class UserEntity(
    @PrimaryKey
    var username: String,
    var name: String,
)

@Entity(
    tableName = "user_profile_image",
    indices = [
        Index(value = ["user"], unique = true)
    ]
)
class UserProfileImageEntity(
    @PrimaryKey
    var user: String,
    var medium: String,
)

//Relations

data class PhotoAndUrlEntity(
    @Embedded val photo: PhotoEntity,
    @Relation(
        parentColumn = "id",
        entityColumn = "photo_id",
    )
    val url: UrlsEntity,
    @Embedded val user: UserEntity,
    @Relation(
        parentColumn = "username",
        entityColumn = "user"
    )
    val profileImage: UserProfileImageEntity
)


