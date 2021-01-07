package com.c3rberuss.mnctest.framework.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.c3rberuss.mnctest.framework.db.dao.FavoritesDao
import com.c3rberuss.mnctest.framework.db.entities.PhotoEntity

@Database(
    entities = [PhotoEntity::class],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract  fun favoritesDao() : FavoritesDao
}