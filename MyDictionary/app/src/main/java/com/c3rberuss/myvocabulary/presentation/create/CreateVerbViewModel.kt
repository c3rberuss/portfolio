package com.c3rberuss.myvocabulary.presentation.create

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.framework.Interactors
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class CreateVerbViewModel @ViewModelInject constructor(private val interactors: Interactors) :
    ViewModel() {

    val baseForm = MutableLiveData<String?>()
    val presentProgressive = MutableLiveData<String?>()
    val past = MutableLiveData<String?>()
    val meaning = MutableLiveData<String?>()

    val state = MutableLiveData<Resource<Verb>>()

    val validData = MutableLiveData<Boolean>()

    init {
        validData.postValue(false)
    }

    fun validateData() {
        validData.postValue(
            baseForm.value?.isNotEmpty() ?: false &&
                    presentProgressive.value?.isNotEmpty() ?: false &&
                    past.value?.isNotEmpty() ?: false

        )
    }

    fun save() {

        state.postValue(Resource.Loading())

        viewModelScope.launch(Dispatchers.IO) {
            val result = interactors.addVerb(
                Verb(
                    baseForm = baseForm.value ?: "",
                    presentProgressive = presentProgressive.value ?: "",
                    past = past.value ?: "",
                    meaning = meaning.value ?: ""
                )
            )

            state.postValue(result)
        }
    }

    fun clearFields() {
        validData.postValue(false)
        state.postValue(null)
        baseForm.postValue(null)
        presentProgressive.postValue(null)
        past.postValue(null)
        meaning.postValue(null)
    }
}