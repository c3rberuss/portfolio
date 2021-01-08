package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.Prestamo;

import java.util.List;

@Dao
public interface CobroProcesadoDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(CobroProcesado cobroProcesado);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<CobroProcesado> cobros);

    @Delete
    void delete(CobroProcesado cobroProcesado);

    @Query("DELETE FROM "+ CobroProcesado.TABLE_NAME)
    void deleteAll();

    @Query("DELETE FROM "+CobroProcesado.TABLE_NAME + " WHERE date(fecha) < date('now', 'localtime')")
    void deleteAllAnteriores();

    @Query("DELETE FROM "+ CobroProcesado.TABLE_NAME+" WHERE sincronizado=1")
    void deleteAllSync();

    @Query("DELETE FROM "+ CobroProcesado.TABLE_NAME+" WHERE id_prestamo=:id_prestamo")
    void deleteAllByPrestamo(int id_prestamo);


    @Query("SELECT COUNT(*) FROM "+CobroProcesado.TABLE_NAME + " WHERE date(fecha) =  date('now', 'localtime') AND id_usuario=:id")
    LiveData<Integer> getCount(int id);

    @Query("SELECT * FROM "+CobroProcesado.TABLE_NAME)
    List<CobroProcesado> getAll();

    //WHERE date(fecha) = date('now')

    @Query("SELECT SUM(monto + mora) FROM "+CobroProcesado.TABLE_NAME + " WHERE date(fecha) = date('now', 'localtime') AND id_usuario=:id")
    LiveData<Double> getTotal(int id);

    @Query("SELECT * FROM "+ Abono.TABLE_NAME)
    List<Abono> getAllAbono();

    @Query("SELECT * FROM "+ CobroProcesado.TABLE_NAME+" WHERE referencia=:ref")
    List<CobroProcesado> getAllCobrosByReferencia(String ref);

    @Query("SELECT * FROM "+ Abono.TABLE_NAME+" WHERE sincronizado=0 AND id_prestamo=:id_prestamo")
    List<Abono> getAllAbonoByPrestamo(int id_prestamo);

    @Query("UPDATE "+Abono.TABLE_NAME+" SET sincronizado=1, fecha=:fecha WHERE id_prestamo=:id_prestamo AND usuario_abono=:id_usuario")
    void updateAbonoBy(int id_prestamo, int id_usuario, String fecha);

    @Query("UPDATE "+CobroProcesado.TABLE_NAME+" SET sincronizado=1, fecha=:fecha  WHERE id_prestamo=:id_prestamo AND id_usuario=:id_usuario")
    void updateCobroByDetalle(int id_prestamo, int id_usuario, String fecha);

    @Query("SELECT cp.* FROM "+CobroProcesado.TABLE_NAME + " as cp  WHERE date(cp.fecha) = date('now', 'localtime') AND cp.id_usuario=:id ORDER BY cp.cliente DESC, date(cp.hora) DESC, cp.id_detalle DESC")
    List<CobroProcesado> getAllJoin(int id);
}
