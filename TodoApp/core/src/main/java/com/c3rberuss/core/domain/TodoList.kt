package com.c3rberuss.core.domain

data class TodoList(
    var title: String,
    var state: Boolean,
){
    var id: String = ""
    var tasks: List<Task> = listOf()
}