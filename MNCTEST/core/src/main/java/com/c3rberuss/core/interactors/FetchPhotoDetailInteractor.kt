package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.UnSplashRepository
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource

class FetchPhotoDetailInteractor(private val repository: UnSplashRepository) {
    suspend operator fun invoke(photoId: String) : Resource<Photo> = repository.fetchPhotoDetail(photoId)
}