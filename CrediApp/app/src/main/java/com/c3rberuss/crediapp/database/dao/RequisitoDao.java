package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Requisito;

import java.util.List;

@Dao
public interface RequisitoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<Requisito> requisitos);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(Requisito requisito);

    @Query("SELECT * FROM "+Requisito.TABLE_NAME+" WHERE id_plan=:id")
    List<Requisito> getAllById(int id);

    @Query("DELETE FROM "+Requisito.TABLE_NAME)
    void deleteAll();

}
