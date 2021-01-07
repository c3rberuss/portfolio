package com.c3rberuss.mnctest.presentation.home

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.interactors.AddToFavoritesInteractor
import com.c3rberuss.core.interactors.FetchPhotosInteractor
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class HomeViewModel @ViewModelInject constructor(private val fetchPhotos: FetchPhotosInteractor, private val addToFavoritesInteractor: AddToFavoritesInteractor) :
    ViewModel() {

    val photos = MutableLiveData<Resource<List<Photo>>>(Resource.Loading())
    private var page: Int = 1

    init {
        fetchAllPhotos()
    }

    fun addToFavorite(photo: Photo){
        viewModelScope.launch(Dispatchers.IO) {
            addToFavoritesInteractor(photo)
        }
    }

    fun fetchAllPhotos() {

        photos.postValue(Resource.Loading())

        viewModelScope.launch(Dispatchers.IO) {
            photos.postValue(fetchPhotos(page))
        }
    }
}