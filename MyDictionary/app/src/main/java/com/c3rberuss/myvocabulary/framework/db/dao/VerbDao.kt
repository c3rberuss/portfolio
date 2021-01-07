package com.c3rberuss.myvocabulary.framework.db.dao

import androidx.room.*
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.framework.db.entities.VerbEntity

@Dao
interface VerbDao {
    @Insert(onConflict = OnConflictStrategy.ABORT)
    suspend fun insert(verb: VerbEntity): Long

    @Update
    suspend fun edit(verb: VerbEntity): Int

    @Delete
    suspend fun delete(verb: VerbEntity): Int

    @Delete
    suspend fun deleteList(verbs: List<VerbEntity>)

    @Query("SELECT * FROM verb")
    suspend fun getAll(): List<VerbEntity>

    @Query("SELECT * FROM verb WHERE id=:id")
    suspend fun getById(id: Long): VerbEntity
}