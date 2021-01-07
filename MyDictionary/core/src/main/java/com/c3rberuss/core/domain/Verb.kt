package com.c3rberuss.core.domain

data class Verb(
    val id: Int = 0,
    val baseForm: String,
    val presentProgressive: String,
    val past: String,
    val meaning: String,
    var selected: Boolean = false
)