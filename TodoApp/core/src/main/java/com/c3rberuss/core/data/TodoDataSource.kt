package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Task
import com.c3rberuss.core.domain.TodoList

abstract class TodoDataSource {
    abstract suspend fun fetchAllTodoLists() : Resource<List<TodoList>>
    abstract suspend fun createTodoList(todoList: TodoList) : Resource<String>
    abstract suspend fun deleteTodoList(todoListId: String) : Resource<Boolean>
    abstract suspend fun updateTodoList(todoList: TodoList) : Resource<Boolean>

    abstract suspend fun fetchTasks(todoListId: String) : Resource<List<Task>>
    abstract suspend fun createTask(todoListId: String, task: Task) : Resource<String>
    abstract suspend fun updateTask(todoListId: String, task: Task) : Resource<Boolean>
    abstract suspend fun deleteTask(todoListId: String, taskId: String) : Resource<Boolean>
}