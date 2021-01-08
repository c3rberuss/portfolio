package com.c3rberuss.crediapp.database.dao;

import com.c3rberuss.crediapp.entities.PagosMora;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

@Dao
public interface PagosMoraDao {

    @Insert
    void insert(PagosMora pagosMora);

    @Query("UPDATE "+ PagosMora.TABLE_NAME+" SET sincronizado=1 WHERE id=:id_pago AND id_usuario=:id_usuario")
    void setSincronizado(int id_pago, int id_usuario);

    @Query("SELECT * FROM "+PagosMora.TABLE_NAME+" WHERE sincronizado=0 AND id_prestamo=:id_prestamo LIMIT 1")
    PagosMora getPagoMoraByPrestamo(int id_prestamo);

    @Query("DELETE FROM "+PagosMora.TABLE_NAME)
    void deleteAll();

}
