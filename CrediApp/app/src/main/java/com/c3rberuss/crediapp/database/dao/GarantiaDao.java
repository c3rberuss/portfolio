package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.entities.SolicitudDetalle;

import java.util.List;

@Dao
public interface GarantiaDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(Garantia garantia);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<Garantia> garantias);

    @Update
    void update(Garantia garantia);

    @Delete
    void delete(Garantia garantia);

    @Query("DELETE FROM "+Garantia.TABLE_NAME+" WHERE id_garantia=:id")
    void deleteById(int id);

    @Query("DELETE FROM "+Garantia.TABLE_NAME+" WHERE sincronizada=1")
    void deleteAllSincronizados();

    @Query("DELETE FROM "+Garantia.TABLE_NAME)
    void deleteAll();

    @Query("SELECT * FROM "+Garantia.TABLE_NAME+" WHERE id_prestamo=:id")
    List<Garantia> getAll(int id);

    @Query("SELECT * FROM "+Garantia.TABLE_NAME+" WHERE sincronizada=0 AND id_prestamo=:id_solicitud")
    List<Garantia> getNoSincronizadas(int id_solicitud);

    @Query("SELECT * FROM "+Garantia.TABLE_NAME+" WHERE sincronizada=0")
    List<Garantia> getNoSync();

    @Query("DELETE FROM "+ SolicitudDetalle.TABLE_NAME+" WHERE id_prestamo=:id ")
    void deleteAllBySolicitud(int id);
}
