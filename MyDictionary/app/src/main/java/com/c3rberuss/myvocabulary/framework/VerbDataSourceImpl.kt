package com.c3rberuss.myvocabulary.framework

import com.c3rberuss.core.data.VerbDataSource
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.framework.db.dao.VerbDao
import com.c3rberuss.myvocabulary.framework.db.entities.VerbEntity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import javax.inject.Inject
import kotlin.Exception

class VerbDataSourceImpl @Inject constructor(private val verbDao: VerbDao) : VerbDataSource {
    override suspend fun add(verb: Verb): Resource<Verb> {
        return withContext(Dispatchers.IO) {

            try {
                val id = verbDao.insert(
                    VerbEntity(
                        baseForm = verb.baseForm,
                        presentProgressive = verb.presentProgressive,
                        past = verb.past,
                        esMeaning = verb.meaning
                    )
                )

                if (id > 0) {

                    val verbInserted = verbDao.getById(id)

                    Resource.Success<Verb>(
                        Verb(
                            id = verbInserted.id,
                            baseForm = verbInserted.baseForm,
                            meaning = verbInserted.esMeaning,
                            presentProgressive = verbInserted.presentProgressive,
                            past = verbInserted.past
                        )
                    )
                } else {
                    Resource.Failure<Verb>(Exception("It Couldn't save the verb"))
                }
            } catch (error: Exception) {
                Resource.Failure<Verb>(error)
            }

        }
    }

    override suspend fun remove(verb: Verb): Resource<Boolean> {
        return withContext(Dispatchers.IO) {
            try {

                val value = verbDao.delete(
                    VerbEntity(
                        id = verb.id,
                        baseForm = verb.baseForm,
                        presentProgressive = verb.presentProgressive,
                        past = verb.past,
                        esMeaning = verb.meaning
                    )
                )

                if (value > 0) {
                    Resource.Success(true)
                } else {
                    Resource.Failure<Boolean>(Exception("It couldn't delete the verb"))
                }

            } catch (error: Exception) {
                Resource.Failure<Boolean>(error)
            }
        }
    }

    override suspend fun remove(verbs: List<Verb>): Resource<Boolean> {
        return withContext(Dispatchers.IO) {
            try {
                
                verbDao.deleteList(verbs.map {
                    VerbEntity(
                        id = it.id,
                        baseForm = it.baseForm,
                        presentProgressive = it.presentProgressive,
                        past = it.past,
                        esMeaning = it.meaning
                    )
                })
                Resource.Success<Boolean>(true)


            } catch (error: Exception) {
                Resource.Failure<Boolean>(error)
            }
        }
    }

    override suspend fun edit(verb: Verb): Resource<Verb> {
        return withContext(Dispatchers.IO) {
            try {

                val value = verbDao.edit(
                    VerbEntity(
                        id = verb.id,
                        baseForm = verb.baseForm,
                        presentProgressive = verb.presentProgressive,
                        past = verb.past,
                        esMeaning = verb.meaning
                    )
                )

                if (value > 0) {

                    val verbInserted = verbDao.getById(verb.id.toLong())

                    Resource.Success(
                        Verb(
                            id = verbInserted.id,
                            baseForm = verbInserted.baseForm,
                            meaning = verbInserted.esMeaning,
                            presentProgressive = verbInserted.presentProgressive,
                            past = verbInserted.past
                        )
                    )
                } else {
                    Resource.Failure<Verb>(Exception("It couldn't edit the verb"))
                }

            } catch (error: Exception) {
                Resource.Failure<Verb>(error)
            }
        }
    }

    override suspend fun getVerbs(): Resource<List<Verb>> {
        return withContext(Dispatchers.IO) {
            val verbs = verbDao.getAll().map {
                Verb(
                    id = it.id,
                    baseForm = it.baseForm,
                    presentProgressive = it.presentProgressive,
                    past = it.past,
                    meaning = it.esMeaning
                )
            }

            Resource.Success(verbs)
        }
    }
}