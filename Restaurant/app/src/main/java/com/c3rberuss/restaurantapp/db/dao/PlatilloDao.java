package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.restaurantapp.entities.Platillo;

import java.util.List;

@Dao
public interface PlatilloDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public long insert(Platillo platillo);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insert(List<Platillo> platillos);

    @Update
    public void update(Platillo platillo);

    @Delete
    public void delete(Platillo platillo);

    @Query("DELETE FROM "+Platillo.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Platillo.TABLE_NAME+" WHERE id_categoria=:id_categoria")
    public LiveData<List<Platillo>> getAllPlatillos(int id_categoria);

    @Query("SELECT * FROM "+Platillo.TABLE_NAME+" WHERE id_categoria=:id_categoria")
    public List<Platillo> getAllPlatillos_(int id_categoria);

    @Query("SELECT * FROM "+Platillo.TABLE_NAME)
    public LiveData<List<Platillo>> getAllPlatillos();

    @Query("SELECT * FROM "+Platillo.TABLE_NAME+" WHERE id_platillo = :id")
    public LiveData<Platillo> get(int id);

    @Query("SELECT * FROM "+Platillo.TABLE_NAME+" WHERE id_platillo = :id")
    public Platillo get_(int id);

}
