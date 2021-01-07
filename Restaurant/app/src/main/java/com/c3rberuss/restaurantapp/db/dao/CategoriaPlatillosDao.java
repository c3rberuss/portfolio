package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Query;

import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.CategoriaPlatillos;

import java.util.List;

@Dao
public interface CategoriaPlatillosDao {

    @Query("SELECT * FROM "+ Categoria.TABLE_NAME)
    public LiveData<List<CategoriaPlatillos>> getAllCategorias();

}
