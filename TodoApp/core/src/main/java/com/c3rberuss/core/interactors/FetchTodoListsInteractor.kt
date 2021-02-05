package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.TodoRepository
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.TodoList

class FetchTodoListsInteractor(private val repository: TodoRepository) {
    suspend operator fun invoke(): Resource<List<TodoList>> = repository.fetchAllTodoLists()
}