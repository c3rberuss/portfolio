package com.c3rberuss.core.domain

data class Task(
    var title: String,
    var note: String,
    var state: Boolean
){
    var id: String = ""
}
