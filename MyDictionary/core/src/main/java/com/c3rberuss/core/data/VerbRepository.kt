package com.c3rberuss.core.data

import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb

class VerbRepository(private val dataSource: VerbDataSource) {
    suspend fun add(verb: Verb): Resource<Verb> = dataSource.add(verb)
    suspend fun edit(verb: Verb): Resource<Verb> = dataSource.edit(verb)
    suspend fun remove(verb: Verb): Resource<Boolean> = dataSource.remove(verb)
    suspend fun getAllVerbs(): Resource<List<Verb>> = dataSource.getVerbs()
    suspend fun removeList(verbs: List<Verb>) : Resource<Boolean> = dataSource.remove(verbs)
}