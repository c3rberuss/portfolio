package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.UnSplashRepository
import com.c3rberuss.core.domain.Photo

class RemoveFromfavoritesInteractor(private val repository: UnSplashRepository) {
    suspend operator fun invoke(photo: Photo) : Boolean = repository.removeFavorite(photo)
}