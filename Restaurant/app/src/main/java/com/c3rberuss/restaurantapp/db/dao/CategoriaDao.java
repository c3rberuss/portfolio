package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.*;


import java.util.List;

@Dao
public interface CategoriaDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Categoria> categorias);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public long insert(Categoria categorias);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Categoria... categorias);

    @Update
    public void update(List<Categoria> categorias);

    @Update
    public void update(Categoria categorias);

    @Update
    public void update(Categoria... categorias);

    @Delete
    public void delete(Categoria categoria);

    @Delete
    public void delete(Categoria... categorias);

    @Query("SELECT * FROM "+Categoria.TABLE_NAME)
    public LiveData<List<Categoria>> get_all();

    @Query("SELECT * FROM "+Categoria.TABLE_NAME)
    public List<Categoria> getAll();

    @Query("SELECT * FROM "+Categoria.TABLE_NAME+" WHERE id=:id")
    public Categoria getCategoria(int id);

    @Query("DELETE FROM "+Categoria.TABLE_NAME)
    public void deleteAll();

}
