package com.c3rberuss.core.domain

sealed class Resource<T> {
    class Loading<T> : Resource<T>()
    class Success<T>(val data: T) : Resource<T>()
    class Failed<T>(val exception: Exception) : Resource<T>()
}