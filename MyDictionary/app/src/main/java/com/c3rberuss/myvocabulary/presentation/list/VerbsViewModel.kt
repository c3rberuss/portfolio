package com.c3rberuss.myvocabulary.presentation.list

import android.util.Log
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.c3rberuss.core.domain.Resource
import com.c3rberuss.core.domain.Verb
import com.c3rberuss.myvocabulary.framework.Interactors
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class VerbsViewModel @ViewModelInject constructor(private val interactors: Interactors) :
    ViewModel() {

    val verbs = MutableLiveData<Resource<List<Verb>>>(Resource.Loading())
    private val selectedVerbs = mutableListOf<Verb>()
    val state = MutableLiveData<Resource<Boolean>>()

    init {
        Log.d("VIEWMODEL", "init: CALLED")
        obtainVerbs()
    }

    fun obtainVerbs() {

        verbs.postValue(Resource.Loading())

        viewModelScope.launch(Dispatchers.IO) {
            verbs.postValue(interactors.getAllVerbs())
        }
    }

    fun addVerbSelected(verb: Verb) {
        selectedVerbs.add(verb)
    }

    fun removeVerbSelected(verb: Verb) {
        selectedVerbs.remove(verb)
    }

    fun deleteAllSelected() {

        state.postValue(Resource.Loading())

        viewModelScope.launch {
            state.postValue(interactors.removeVerbs(selectedVerbs))
        }
    }
}