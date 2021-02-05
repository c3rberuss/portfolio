package com.c3rberuss.todoapp.presentation.todolist

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Task
import com.c3rberuss.core.domain.TodoList
import com.c3rberuss.core.interactors.CreateTodoListInteractor
import com.c3rberuss.core.interactors.FetchTodoListsInteractor
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class TodoListViewModel @ViewModelInject constructor(
    private val fetchTodoList: FetchTodoListsInteractor,
    private val createTodoList: CreateTodoListInteractor
) : ViewModel() {

    val todoListLiveData = MutableLiveData<Resource<List<TodoList>>> (Resource.Loading())

    init {
        fetchToDoList()
    }

    fun fetchToDoList() {
        viewModelScope.launch(Dispatchers.IO) {
            todoListLiveData.postValue(Resource.Loading())
            todoListLiveData.postValue(fetchTodoList())
        }
    }

    fun createToDoList() {
        viewModelScope.launch(Dispatchers.IO) {

            val todoList = TodoList(title = "Exmaple", state = false)
            todoList.tasks = listOf(
                Task(title = "Example Task", note = "Nothing", state = false)
            )

            createTodoList(todoList)
        }
    }
}