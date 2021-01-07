package com.c3rberuss.mnctest.di

import android.content.Context
import androidx.room.Room
import com.c3rberuss.mnctest.framework.db.AppDatabase
import com.c3rberuss.mnctest.framework.db.dao.FavoritesDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class DatabaseModule {
    @Singleton
    @Provides
    fun provideDatabase(@ApplicationContext context: Context): AppDatabase {
        return Room.databaseBuilder(context, AppDatabase::class.java, "mnc_test_database").build()
    }

    @Singleton
    @Provides
    fun providesFavoritesDao(db: AppDatabase): FavoritesDao {
        return db.favoritesDao()
    }
}