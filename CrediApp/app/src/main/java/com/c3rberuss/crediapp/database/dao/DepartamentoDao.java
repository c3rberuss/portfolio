package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Departamento;
import com.c3rberuss.crediapp.entities.DepartamentoMunicipio;

import java.util.List;

@Dao
public interface DepartamentoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Departamento> departamentos);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Departamento departamento);

    @Query("DELETE FROM "+Departamento.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Departamento.TABLE_NAME)
    public LiveData<List<Departamento>> getAll();

    @Query("SELECT * FROM "+ Departamento.TABLE_NAME)
    public LiveData<List<DepartamentoMunicipio>> getAllDep();

    @Query("SELECT * FROM "+ Departamento.TABLE_NAME)
    public List<DepartamentoMunicipio> getAllDep_();

    @Query("SELECT nombre_departamento FROM "+Departamento.TABLE_NAME+ " WHERE id_departamento=:id")
    String getDepa(int id);

}
