package com.c3rberuss.restaurantapp.db.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.restaurantapp.entities.Direccion;

import java.util.List;

@Dao
public interface DireccionDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(Direccion dir);

    @Query("UPDATE "+Direccion.TABLE_NAME+" SET defecto=1 WHERE id=:id_direccion")
    void updateDefault(int id_direccion);

    @Query("UPDATE "+Direccion.TABLE_NAME+" SET defecto=0")
    void updateNotDefaultAll();

    @Query("SELECT * FROM "+Direccion.TABLE_NAME+" WHERE id_usuario=:id_usuario")
    LiveData<List<Direccion>> getDirecciones(int id_usuario);

    @Delete
    void delete(Direccion direccion);





}
