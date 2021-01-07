package com.c3rberuss.myvocabulary.framework

import com.c3rberuss.core.interactors.*

data class Interactors(
    val addVerb: AddVerb,
    val editVerb: EditVerb,
    val removeVerb: RemoveVerb,
    val getAllVerbs: GetAllVerbs,
    val removeVerbs: RemoveVerbs
)