package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Municipio;

import java.util.List;

@Dao
public interface MunicipioDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Municipio> municipios);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Municipio municipio);

    @Query("DELETE FROM "+Municipio.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Municipio.TABLE_NAME+" WHERE id_departamento_municipio=:id_departamento ")
    public LiveData<List<Municipio>> getAllByDep(int id_departamento);

    @Query("SELECT nombre_municipio FROM "+ Municipio.TABLE_NAME+ " WHERE id_municipio=:id")
    String getMuni(int id);

}
