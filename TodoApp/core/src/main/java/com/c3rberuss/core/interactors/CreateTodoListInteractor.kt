package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.TodoRepository
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.TodoList

class CreateTodoListInteractor(private val repository: TodoRepository) {
    suspend operator fun invoke(todoList: TodoList): Resource<String> =
        repository.createTodoList(todoList)
}