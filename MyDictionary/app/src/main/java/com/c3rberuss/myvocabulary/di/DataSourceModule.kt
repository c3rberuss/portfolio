package com.c3rberuss.myvocabulary.di

import com.c3rberuss.core.data.VerbDataSource
import com.c3rberuss.myvocabulary.framework.VerbDataSourceImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import javax.inject.Singleton

@Module
@InstallIn(ApplicationComponent::class)
abstract class DataSourceModule {
    @Singleton
    @Binds
    abstract fun bindVerbDataSource(verbDataSourceImpl: VerbDataSourceImpl): VerbDataSource
}