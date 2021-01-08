package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.crediapp.entities.SolicitudDetalle;

import java.util.List;

@Dao
public interface SolicitudDetalleDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(SolicitudDetalle solicitudDetalle);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<SolicitudDetalle> solicitudDetalles);

    @Update
    void update(SolicitudDetalle solicitudDetalle);

    @Delete
    void delete(SolicitudDetalle solicitudDetalle);

    @Query("DELETE FROM "+SolicitudDetalle.TABLE_NAME+" WHERE id_detalle=:id")
    void deleteById(int id);

    @Query("DELETE FROM "+SolicitudDetalle.TABLE_NAME+" WHERE sincronizado=1 ")
    void deleteAllSincronizados();

    @Query("DELETE FROM "+SolicitudDetalle.TABLE_NAME)
    void deleteAll();

    @Query("SELECT * FROM "+SolicitudDetalle.TABLE_NAME+" WHERE id_prestamo=:id")
    List<SolicitudDetalle> getAll(int id);

    @Query("SELECT * FROM "+ SolicitudDetalle.TABLE_NAME+" WHERE sincronizado=0 AND id_prestamo=:id_solicitud")
    List<SolicitudDetalle> getNoSincronizadas(int id_solicitud);

    @Query("DELETE FROM "+SolicitudDetalle.TABLE_NAME+" WHERE id_prestamo=:id ")
    void deleteAllBySolicitud(int id);
}
