package com.c3rberuss.core.interactors

import com.c3rberuss.core.data.UnSplashRepository
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.User

class FetchUserProfileInteractor(private val repository: UnSplashRepository) {
    suspend operator fun invoke(username: String): Resource<User> = repository.fetchUserProfile(username)
}