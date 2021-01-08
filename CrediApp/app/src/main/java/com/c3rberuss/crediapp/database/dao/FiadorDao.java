package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.crediapp.entities.Fiador;

import java.util.List;

@Dao
public interface FiadorDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(Fiador fiador);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insert(List<Fiador> fiadors);

    @Update
    void update(Fiador fiador);

    @Delete
    void delete(Fiador fiador);

    @Query("DELETE FROM "+Fiador.TABLE_NAME+" WHERE idFiador=:id")
    void deleteById(int id);

    @Query("DELETE FROM "+Fiador.TABLE_NAME+" WHERE sincronizado=1")
    void deleteAllSincronizados();

    @Query("DELETE FROM "+Fiador.TABLE_NAME)
    void deleteAll();

    @Query("SELECT * FROM "+Fiador.TABLE_NAME+" WHERE idPrestamo=:id LIMIT 1")
    Fiador get(int id);

    @Query("SELECT * FROM "+Fiador.TABLE_NAME+" WHERE idPrestamo=:id AND sincronizado=0 LIMIT 1")
    Fiador getNoSincronizado(int id);

    @Query("UPDATE "+ Fiador.TABLE_NAME+" SET idFiador=:id_cliente_n WHERE idFiador=:id_cliente_a AND sincronizado=0")
    void actualizarIdFiador(int id_cliente_n, int id_cliente_a);
}
