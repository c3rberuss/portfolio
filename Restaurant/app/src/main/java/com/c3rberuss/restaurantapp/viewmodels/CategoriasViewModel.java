package com.c3rberuss.restaurantapp.viewmodels;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.CategoriaPlatillos;
import com.c3rberuss.restaurantapp.repository.AppRepository;

import java.util.List;

public class CategoriasViewModel extends AndroidViewModel {

    private AppRepository repository;

    private LiveData<List<CategoriaPlatillos>> allCategories;

    public CategoriasViewModel(@NonNull Application application) {
        super(application);

        repository = new AppRepository(application);
        allCategories = repository.getAllCategoria();

    }

    public LiveData<List<CategoriaPlatillos>> getAllCategories() {
        return repository.getAllCategoria();
    }

    public void setAllCategories(LiveData<List<CategoriaPlatillos>> allCategories) {
        this.allCategories = allCategories;
    }

}
