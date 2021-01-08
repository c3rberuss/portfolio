package com.c3rberuss.crediapp.database.dao;


import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;


import com.c3rberuss.crediapp.entities.PrestamoDetalle;

import java.util.List;

@Dao
public interface PrestamoDetalleDao {
    @Query("SELECT * FROM prestamo_detalle")
    List<PrestamoDetalle> getAllPrestamoDetalle();

    String sql1="SELECT * FROM prestamo_detalle WHERE pagado=0 AND  id_prestamo=:id_prestamo";
    @Query(sql1)
    List<PrestamoDetalle> getByIdPrestamoDetalle(int id_prestamo);


    @Query("SELECT * FROM prestamo_detalle WHERE pagado=0 AND  id_prestamo=:id_prestamo")
    LiveData<List<PrestamoDetalle>> getByIdPrestamoDetalle2(int id_prestamo);

    @Query("SELECT * FROM prestamo_detalle WHERE id_prestamo LIKE :id_prestamo")
    boolean getExisteIdPrestamoDet(int id_prestamo);


    String sql3="SELECT SUM(monto) FROM (SELECT monto FROM  prestamo_detalle  WHERE pagado=0 AND  id_prestamo=:id_prestamo  ORDER BY id_prestamo ASC LIMIT :ncuotas)";
    @Query(sql3)
    double getMontoPrestamoDetalleLimit(int id_prestamo, int ncuotas);

    String sql4="SELECT SUM(mora) FROM (SELECT mora FROM  prestamo_detalle  WHERE pagado=0 AND  id_prestamo=:id_prestamo  ORDER BY id_prestamo ASC LIMIT :ncuotas)";
    @Query(sql4)
    double getMoraPrestamoDetalleLimit(int id_prestamo, int ncuotas);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertPrestamo(PrestamoDetalle prestamo);

    @Delete
    void deletePrestamo(PrestamoDetalle prestamo);
    @Update
    void updatePrestamoDetalle(PrestamoDetalle prestamo);

    String sql5=" UPDATE prestamo_detalle  SET pagado=1, fecha_pago=:fecha_pago," +
            " hora_pago=:hora_pago, referencia=:referencia, mora=:mora, sincronizado=0," +
            " id_cobrador=:id_cobrador, efectivo=:efectivo " +
            "WHERE pagado=0 AND  id_detalle=:id_detalle ";
    @Query(sql5)
    void updateByIdPrestamoDetalle(int id_detalle, String fecha_pago, String hora_pago, String referencia, double mora, int id_cobrador, double efectivo);

    String sql6="SELECT pd.* FROM  prestamo_detalle AS pd WHERE pd.pagado=1 AND  pd.id_prestamo= :id_prestamo AND pd.fecha_pago=:fecha_pago";
    @Query(sql6)
    List<PrestamoDetalle> getCuotaPagadaFecha(int id_prestamo, String fecha_pago);

    String sql7="SELECT pd.* FROM  prestamo_detalle AS pd WHERE pd.pagado=1  AND pd.fecha_pago=:fecha_pago";
    @Query(sql7)
    List<PrestamoDetalle> getCuotaPagadaporFecha(String fecha_pago);


    String sql8="SELECT *  FROM  prestamo_detalle  WHERE pagado=0 AND  id_prestamo=:id_prestamo  ORDER BY id_detalle ASC LIMIT :ncuotas";
    @Query(sql8)
    List<PrestamoDetalle>  getPrestamoDetalleByCuota(int id_prestamo, int ncuotas);


    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insert(List<PrestamoDetalle> prestamoDetalles);

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insert(PrestamoDetalle prestamoDetalle);

    @Query("DELETE FROM "+ PrestamoDetalle.TABLE_NAME+" WHERE sincronizado=1")
    void delete();

    @Query("DELETE FROM "+ PrestamoDetalle.TABLE_NAME+" WHERE abonado = 0")
    void deleteAll();

    @Query("DELETE FROM "+ PrestamoDetalle.TABLE_NAME)
    void deleteAll2();

    @Query("SELECT * FROM "+PrestamoDetalle.TABLE_NAME+" WHERE sincronizado=0 AND id_prestamo=:id AND pagado=1 OR abonado=1")
    List<PrestamoDetalle> getPrestamoDetNoSincronizados(int id);

    @Query("SELECT * FROM "+PrestamoDetalle.TABLE_NAME+" WHERE sincronizado=0 AND id_prestamo=:id AND abonado=1")
    List<PrestamoDetalle> getPrestamoDetNoSincronizadosAbonados(int id);


    @Query("SELECT COUNT(*) FROM "+PrestamoDetalle.TABLE_NAME+" WHERE sincronizado=0")
    int getCount();

    @Query("SELECT COUNT(*) FROM "+PrestamoDetalle.TABLE_NAME+" WHERE id_prestamo=:id_prestamo AND pagado=0")
    int getCuotasPendientesByPrestamo(int id_prestamo);

    @Query("SELECT * FROM "+PrestamoDetalle.TABLE_NAME+" WHERE date(fecha_vence) < date(:date) AND id_prestamo=:id_prestamo")
    List<PrestamoDetalle> getDetalleAntesHoy(String date, int id_prestamo);

    @Query("SELECT pd.* FROM  prestamo_detalle AS pd WHERE pd.pagado=1 AND  pd.id_prestamo= :id_prestamo AND pd.referencia=:referencia")
    List<PrestamoDetalle> getCuotaPagadaReferencia(int id_prestamo, String referencia);

    @Query("SELECT * FROM "+PrestamoDetalle.TABLE_NAME+" WHERE ncuota=:ncuota AND id_prestamo=:id_prestamo LIMIT 1")
    PrestamoDetalle getCuotaAbonar(int ncuota, int id_prestamo);

    @Query("SELECT DATE(MIN(fecha_vence), '+7 day') FROM "+PrestamoDetalle.TABLE_NAME+ " WHERE id_prestamo=:id_prestamo AND pagado=0")
    String getSiguienteCuota(int id_prestamo);
}
