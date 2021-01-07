package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb

interface VerbDataSource {
    suspend fun add(verb: Verb) : Resource<Verb>
    suspend fun remove(verb: Verb) : Resource<Boolean>
    suspend fun edit(verb: Verb) : Resource<Verb>
    suspend fun getVerbs() : Resource<List<Verb>>
    suspend fun remove(verbs: List<Verb>) : Resource<Boolean>
}