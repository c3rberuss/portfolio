package com.c3rberuss.core.domain

sealed class Resource<out T> {
    class Loading<out T> : Resource<T>()
    class Success<T>(var data: T) : Resource<T>()
    class Failure<out T>(var exception: Exception) : Resource<T>()
}