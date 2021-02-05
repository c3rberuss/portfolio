package com.c3rberuss.todoapp.framework.db

import android.util.Log
import com.c3rberuss.core.data.TodoDataSource
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Task
import com.c3rberuss.core.domain.TodoList
import com.google.android.gms.tasks.Tasks
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.QueryDocumentSnapshot
import java.util.concurrent.TimeUnit
import javax.inject.Inject

class TodoDataSourceImpl @Inject constructor() : TodoDataSource() {

    private val db: FirebaseFirestore = FirebaseFirestore.getInstance()
    private val toDoCollectionName = "todo_list"
    private val tasksCollectionName = "tasks"
    private val ref = db.collection("$toDoCollectionName")

    override suspend fun fetchAllTodoLists(): Resource<List<TodoList>> {

        try {
            val result = Tasks.await(ref.get(), 5, TimeUnit.SECONDS)
            val todoLists = result.map { it.toTodoList() }

            todoLists.forEach { println("TITLE: ${it.title}") }

            return Resource.Success(todoLists)

        } catch (e: Exception) {
            Log.e("EXCEPTION", e.message!!)
        }

        return Resource.Success(listOf())
    }

    override suspend fun createTodoList(todoList: TodoList): Resource<String> {

        return try {

            val document = todoList.toDocument()
            val result = Tasks.await(ref.add(document), 5, TimeUnit.SECONDS)

            for ((index, listTask) in todoList.tasks.withIndex()) {
                val taskId = createTask(result.id, listTask)
            }

            Resource.Success(result.id)

        } catch (e: Exception) {
            Log.e("EXCEPTION ON ADD", e.message!!)
            Resource.Failure(e)
        }
    }

    override suspend fun deleteTodoList(todoListId: String): Resource<Boolean> {
        return try {

            val ref = db.document("$toDoCollectionName/$todoListId")
            val result = Tasks.await(ref.delete(), 4, TimeUnit.SECONDS)

            Resource.Success(true)
        } catch (e: Exception) {
            Resource.Failure(e)
        }
    }

    override suspend fun updateTodoList(todoList: TodoList): Resource<Boolean> {
        return try {
            val ref = db.document("$toDoCollectionName/${todoList.id}")

            val newData = todoList.toDocument()

            val result = Tasks.await(ref.set(newData), 5, TimeUnit.SECONDS)

            Resource.Success(true)
        } catch (e: Exception) {
            Resource.Failure(e)
        }
    }

    override suspend fun fetchTasks(todoListId: String): Resource<List<Task>> {
        try {
            val result =
                Tasks.await(
                    db.collection("$toDoCollectionName/$todoListId/$tasksCollectionName").get(),
                    5, TimeUnit.SECONDS
                )

            val tasks = result.map { it.toTask() }

            return Resource.Success(tasks)

        } catch (e: Exception) {
            Log.e("EXCEPTION", e.message!!)
        }

        return Resource.Success(listOf())
    }

    override suspend fun createTask(todoListId: String, task: Task): Resource<String> {
        return try {
            val ref = db.collection("$toDoCollectionName/$todoListId/$tasksCollectionName")


            val result = Tasks.await(ref.add(task.toDocument()), 4, TimeUnit.SECONDS)

            Resource.Success(result.id)

        } catch (e: Exception) {
            Log.e("EXCEPTION ON ADD", e.message!!)
            Resource.Failure(e)
        }
    }

    override suspend fun updateTask(todoListId: String, task: Task): Resource<Boolean> {
        return try {
            val ref = db.document("$toDoCollectionName/$todoListId/$tasksCollectionName/${task.id}")

            val newData = task.toDocument()

            val result = Tasks.await(ref.set(newData), 5, TimeUnit.SECONDS)

            Resource.Success(true)
        } catch (e: Exception) {
            Resource.Failure(e)
        }
    }

    override suspend fun deleteTask(todoListId: String, taskId: String): Resource<Boolean> {
        return try {

            val ref = db.document("$toDoCollectionName/$todoListId/$tasksCollectionName/$taskId")
            val result = Tasks.await(ref.delete(), 4, TimeUnit.SECONDS)

            Resource.Success(true)
        } catch (e: Exception) {
            Resource.Failure(e)
        }
    }

    private fun QueryDocumentSnapshot.toTodoList(): TodoList {
        val todoList = TodoList(
            title = this["title"].toString(),
            state = (this["state"] as Boolean),
        )

        todoList.id = id

        return todoList
    }

    private fun QueryDocumentSnapshot.toTask(): Task {
        val task = Task(
            title = this["title"].toString(),
            state = (this["state"] as Boolean),
            note = this["note"].toString()
        )

        task.id = id
        return task
    }

    private fun TodoList.toDocument(): Map<String, Any> {
        return mapOf(
            "title" to title,
            "state" to false,
        )
    }

    private fun Task.toDocument(): Map<String, Any> {
        return mapOf(
            "title" to title,
            "note" to note,
            "state" to false,
        )
    }
}