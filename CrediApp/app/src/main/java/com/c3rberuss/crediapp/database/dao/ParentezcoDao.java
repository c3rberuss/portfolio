package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Parentezco;

import java.util.List;

@Dao
public interface ParentezcoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Parentezco> parentezcos);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(Parentezco parentezco);

    @Query("DELETE FROM "+Parentezco.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Parentezco.TABLE_NAME)
    public LiveData<List<Parentezco>> getAll();

}
