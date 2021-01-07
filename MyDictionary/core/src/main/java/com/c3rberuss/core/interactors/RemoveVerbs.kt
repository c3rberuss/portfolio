package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.VerbRepository
import com.c3rberuss.core.domain.Verb

class RemoveVerbs(private val verbRepository: VerbRepository) {
    suspend operator fun invoke(verbs: List<Verb>) = verbRepository.removeList(verbs)
}