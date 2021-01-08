package com.c3rberuss.crediapp.database.dao;

import com.c3rberuss.crediapp.entities.Abono;

import java.util.List;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

@Dao
public interface AbonoDao {

    @Insert()
    long insert(Abono abono);

    @Query("SELECT * FROM "+Abono.TABLE_NAME+" WHERE sincronizado=0")
    List<Abono> getAllNoSync();

    @Query("SELECT * FROM "+Abono.TABLE_NAME+" WHERE sincronizado=1")
    List<Abono> getAllSync();

    @Query("SELECT * FROM "+Abono.TABLE_NAME)
    List<Abono> getAll();

    @Query("SELECT * FROM "+Abono.TABLE_NAME+" WHERE id_detalle=:id_detalle AND usuario_abono=:id_usuario")
    Abono getAbono(int id_detalle, int id_usuario);

    @Update
    void update(Abono abono);

    @Delete
    void delete(Abono abono);

    @Query("DELETE FROM "+Abono.TABLE_NAME+" WHERE sincronizado=1")
    void deleteAllSync();

    @Query("DELETE FROM "+Abono.TABLE_NAME)
    void deleteAll();

    @Query("DELETE FROM "+Abono.TABLE_NAME+" WHERE sincronizado=0")
    void deleteAllNoSync();

}
