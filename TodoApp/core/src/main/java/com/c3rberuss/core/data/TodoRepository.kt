package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Task
import com.c3rberuss.core.domain.TodoList

class TodoRepository(private val dataSource: TodoDataSource) {
    suspend fun fetchAllTodoLists(): Resource<List<TodoList>> = dataSource.fetchAllTodoLists()
    suspend fun createTodoList(todoList: TodoList): Resource<String> =
        dataSource.createTodoList(todoList)

    suspend fun deleteTodoList(todoListId: String): Resource<Boolean> =
        dataSource.deleteTodoList(todoListId)

    suspend fun updateTodoList(todoList: TodoList): Resource<Boolean> =
        dataSource.updateTodoList(todoList)

    suspend fun createTask(todoListId: String, task: Task): Resource<String> =
        dataSource.createTask(todoListId, task)

    suspend fun updateTask(todoListId: String, task: Task): Resource<Boolean> =
        dataSource.updateTask(todoListId, task)

    suspend fun deleteTask(todoListId: String, taskId: String): Resource<Boolean> =
        dataSource.deleteTask(todoListId, taskId)
}