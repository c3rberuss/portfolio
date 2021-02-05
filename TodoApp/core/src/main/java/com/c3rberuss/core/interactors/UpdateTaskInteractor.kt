package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.TodoRepository
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Task


class UpdateTaskInteractor(private val repository: TodoRepository) {
    suspend operator fun invoke(todoListId: String, task: Task): Resource<Boolean> =
        repository.updateTask(todoListId, task)
}