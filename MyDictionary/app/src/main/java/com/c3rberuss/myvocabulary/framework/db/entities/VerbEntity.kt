package com.c3rberuss.myvocabulary.framework.db.entities

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(tableName = "verb", indices = [Index(value = ["base_form"], unique = true)])
data class VerbEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,

    @ColumnInfo(name = "base_form")
    val baseForm: String,

    @ColumnInfo(name = "present_progressive_form")
    val presentProgressive: String,

    @ColumnInfo(name = "past_form")
    val past: String,

    @ColumnInfo(name = "es_meaning")
    val esMeaning: String
)