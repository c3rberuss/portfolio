package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.UnSplashRepository

class GetAllFavoritePhotosInteractor(private val repository: UnSplashRepository) {
    suspend operator fun invoke() = repository.getAllFavoritePhotos()
}