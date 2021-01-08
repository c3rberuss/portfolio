package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.crediapp.entities.SolicitudCredito;

import java.util.List;

@Dao
public interface SolicitudDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(SolicitudCredito solicitudCredito);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<SolicitudCredito> solicitudCreditos);

    @Update
    void update(SolicitudCredito solicitudCredito);

    @Delete
    void delete(SolicitudCredito solicitudCredito);

    @Query("DELETE FROM "+SolicitudCredito.TABLE_NAME+" WHERE id_solicitud=:id")
    void deleteById(int id);

    @Query("DELETE FROM "+SolicitudCredito.TABLE_NAME+" WHERE sincronizada=1")
    void deleteAllSincronizados();

    @Query("DELETE FROM "+SolicitudCredito.TABLE_NAME)
    void deleteAll();

    @Query("SELECT * FROM "+SolicitudCredito.TABLE_NAME+" WHERE id_vendedor=:id")
    LiveData<List<SolicitudCredito>> getAll(int id);

    @Query("SELECT COUNT(*) FROM "+SolicitudCredito.TABLE_NAME+" WHERE id_cliente=:id_cliente")
    int tieneSolicitudPendiente(int id_cliente);


    @Query("SELECT COUNT(*) FROM "+SolicitudCredito.TABLE_NAME+" WHERE id_cliente=:id_cliente AND refinanciamiento=1")
    int tieneSolicitudRefPendiente(int id_cliente);

    @Query("SELECT * FROM "+SolicitudCredito.TABLE_NAME+" WHERE sincronizada=0 AND refinanciamiento = 0")
    List<SolicitudCredito> getNoSincronizadas();

    @Query("SELECT * FROM "+SolicitudCredito.TABLE_NAME+" WHERE sincronizada=0 AND refinanciamiento = 1")
    List<SolicitudCredito> getRefNoSincronizadas();

    @Query("DELETE FROM "+SolicitudCredito.TABLE_NAME+" WHERE sincronizada=1 AND refinanciamiento = 1")
    void deleteRefSincronizadas();

    @Query("UPDATE "+SolicitudCredito.TABLE_NAME+" SET id_cliente=:id_cliente_n WHERE id_cliente=:id_cliente_a AND refinanciamiento=0 AND sincronizada=0")
    void actualizarIdCliente(int id_cliente_n, int id_cliente_a);

}
