package com.c3rberuss.mnctest.di

import com.c3rberuss.core.data.LocalDataSource
import com.c3rberuss.core.data.UnSplashDataSource
import com.c3rberuss.core.data.UnSplashRepository
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.ProfileImage
import com.c3rberuss.core.domain.Urls
import com.c3rberuss.core.domain.User
import com.c3rberuss.core.interactors.*
import com.c3rberuss.mnctest.framework.network.serializers.PhotoSerializer
import com.c3rberuss.mnctest.framework.network.serializers.ProfileImageSerializer
import com.c3rberuss.mnctest.framework.network.serializers.UrlsSerializer
import com.c3rberuss.mnctest.framework.network.serializers.UserSerializer
import com.c3rberuss.mnctest.utils.DataClassMapper

import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent

@Module
@InstallIn(ActivityComponent::class)
class MncTestApplicationModule {

    @Provides
    fun providesPhotoMapper() : DataClassMapper<PhotoSerializer, Photo> {
        val userMapper = DataClassMapper<UserSerializer, User>()
            .register(
                "profileImage",
                DataClassMapper<ProfileImageSerializer, ProfileImage>()
            )

        val photoMapper = DataClassMapper<PhotoSerializer, Photo>()
        val urlMapper = DataClassMapper<UrlsSerializer, Urls>()

        photoMapper.register("urls", urlMapper)
        photoMapper.register("user", userMapper)

        return photoMapper
    }

    @Provides
    fun providesUnSplashRepository(
        localDataSource: LocalDataSource,
        remoteDataSource: UnSplashDataSource
    ): UnSplashRepository {
        return UnSplashRepository(remoteDataSource, localDataSource)
    }


    @Provides
    fun providesFetchPhotosInteractor(repository: UnSplashRepository): FetchPhotosInteractor {
        return FetchPhotosInteractor(repository)
    }

    @Provides
    fun providesFetchPhotoDetailInteractor(repository: UnSplashRepository): FetchPhotoDetailInteractor {
        return FetchPhotoDetailInteractor(repository)
    }

    @Provides
    fun providesFetchUserProfileInteractor(repository: UnSplashRepository): FetchUserProfileInteractor {
        return FetchUserProfileInteractor(repository)
    }

    @Provides
    fun providesAddToFavoriteInteractor(repository: UnSplashRepository): AddToFavoritesInteractor {
        return AddToFavoritesInteractor(repository)
    }

    @Provides
    fun providesRemoveFromFavoritesInteractor(repository: UnSplashRepository): RemoveFromfavoritesInteractor {
        return RemoveFromfavoritesInteractor(repository)
    }

    @Provides
    fun providesGetAllFavoritePhotosInteractor(repository: UnSplashRepository): GetAllFavoritePhotosInteractor {
        return GetAllFavoritePhotosInteractor(repository)
    }

}