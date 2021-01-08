package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Frecuencia;

import java.util.List;

@Dao
public interface FrecuenciaDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Frecuencia> frecuencias);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Frecuencia frecuencia);

    @Query("DELETE FROM "+Frecuencia.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Frecuencia.TABLE_NAME)
    public LiveData<List<Frecuencia>> getAllLive();

    @Query("SELECT * FROM "+Frecuencia.TABLE_NAME)
    public List<Frecuencia> getAll();

    @Query("SELECT * FROM "+Frecuencia.TABLE_NAME+" WHERE id=:id")
    Frecuencia getById(int id);

}
