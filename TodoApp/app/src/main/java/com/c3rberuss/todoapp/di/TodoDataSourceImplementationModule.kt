package com.c3rberuss.todoapp.di

import com.c3rberuss.core.data.TodoDataSource
import com.c3rberuss.todoapp.framework.db.TodoDataSourceImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent

@InstallIn(ActivityComponent::class)
@Module
abstract class TodoDataSourceImplementationModule {

    @Binds
    abstract fun bindsTodoDataSource(todoDataSourceImpl: TodoDataSourceImpl): TodoDataSource
}