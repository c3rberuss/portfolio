package com.c3rberuss.mnctest.di

import com.c3rberuss.core.data.LocalDataSource
import com.c3rberuss.core.data.UnSplashDataSource
import com.c3rberuss.mnctest.framework.LocalDataSourceImpl
import com.c3rberuss.mnctest.framework.UnSplashDataSourceImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent

@Module
@InstallIn(ActivityComponent::class)
abstract class MncTestDataSourcesImplementationModule {

    @Binds
    abstract fun bindLocalDataSource(localDataSourceImpl: LocalDataSourceImpl): LocalDataSource

    @Binds
    abstract fun bindRemoteDataSource(remoteDataSource: UnSplashDataSourceImpl): UnSplashDataSource
}