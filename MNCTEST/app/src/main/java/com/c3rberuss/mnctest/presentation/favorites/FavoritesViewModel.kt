package com.c3rberuss.mnctest.presentation.favorites

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.c3rberuss.core.domain.Photo
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.interactors.GetAllFavoritePhotosInteractor
import com.c3rberuss.core.interactors.RemoveFromfavoritesInteractor
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FavoritesViewModel @ViewModelInject constructor(
    private val getAllFavoritesInteractor: GetAllFavoritePhotosInteractor,
    private val removeFromFavoritesInteractor: RemoveFromfavoritesInteractor
) : ViewModel() {

    val photos = MutableLiveData<Resource<List<Photo>>>(Resource.Loading())
    var updateUi: Boolean = true

    init {
        getAllFavorites()
    }

    fun removeFromFavorite(photo: Photo){
        viewModelScope.launch(Dispatchers.IO) {
            removeFromFavoritesInteractor(photo)
            // photos.postValue(getAllFavoritesInteractor())
        }
    }

    fun getAllFavorites() {

        photos.postValue(Resource.Loading())

        viewModelScope.launch(Dispatchers.IO) {
            photos.postValue(getAllFavoritesInteractor())
        }
    }

}