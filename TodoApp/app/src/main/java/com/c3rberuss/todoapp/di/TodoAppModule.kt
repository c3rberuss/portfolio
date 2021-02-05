package com.c3rberuss.todoapp.di

import com.c3rberuss.core.data.TodoDataSource
import com.c3rberuss.core.data.TodoRepository
import com.c3rberuss.core.interactors.CreateTodoListInteractor
import com.c3rberuss.core.interactors.FetchTodoListsInteractor
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent

@InstallIn(ActivityComponent::class)
@Module
class TodoAppModule {

    @Provides
    fun providesTodoRepository(todoDataSource: TodoDataSource) : TodoRepository{
        return TodoRepository(todoDataSource)
    }

    @Provides
    fun providesFetchTodoListInteractor(repository: TodoRepository) : FetchTodoListsInteractor {
        return FetchTodoListsInteractor(repository)
    }

    @Provides
    fun provideCreateTodoListInteractor(repository: TodoRepository) : CreateTodoListInteractor{
        return CreateTodoListInteractor(repository)
    }
}