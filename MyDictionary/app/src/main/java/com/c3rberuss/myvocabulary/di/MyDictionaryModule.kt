package com.c3rberuss.myvocabulary.di

import android.content.Context
import androidx.room.Room
import com.c3rberuss.core.data.VerbDataSource
import com.c3rberuss.core.data.VerbRepository
import com.c3rberuss.core.interactors.*
import com.c3rberuss.myvocabulary.framework.Interactors
import com.c3rberuss.myvocabulary.framework.db.VerbDatabase
import com.c3rberuss.myvocabulary.framework.db.dao.VerbDao
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
class MyDictionaryModule {

    @Singleton
    @Provides
    fun provideDatabase(@ApplicationContext context: Context): VerbDatabase {
        return Room.databaseBuilder(context, VerbDatabase::class.java, "verb_database").build()
    }

    @Singleton
    @Provides
    fun provideVerbDao(db: VerbDatabase): VerbDao {
        return db.verbDao()
    }

    @Singleton
    @Provides
    fun provideVerbRepository(dataSource: VerbDataSource): VerbRepository {
        return VerbRepository(dataSource)
    }

    @Singleton
    @Provides
    fun provideInteractors(verbRepository: VerbRepository): Interactors {
        return Interactors(
            AddVerb(verbRepository),
            EditVerb(verbRepository),
            RemoveVerb(verbRepository),
            GetAllVerbs(verbRepository),
            RemoveVerbs(verbRepository)
        )
    }

}