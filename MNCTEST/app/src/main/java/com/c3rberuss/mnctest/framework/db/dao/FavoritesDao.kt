package com.c3rberuss.mnctest.framework.db.dao

import androidx.room.*
import com.c3rberuss.mnctest.framework.db.entities.PhotoEntity

@Dao
interface FavoritesDao {
    @Query("SELECT * from favorite_photo")
    fun getFavorites() : List<PhotoEntity>

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    fun addFavorite(photo: PhotoEntity) : Long

    @Query("SELECT * FROM favorite_photo WHERE id=:photoId")
    fun getFavorite(photoId: String) : PhotoEntity

    @Update(onConflict = OnConflictStrategy.REPLACE)
    fun updateFavorite(photo: PhotoEntity) : Int

    @Delete
    fun removeFavorite(photo: PhotoEntity)
}