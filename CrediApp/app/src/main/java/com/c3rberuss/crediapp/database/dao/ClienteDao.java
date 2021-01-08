package com.c3rberuss.crediapp.database.dao;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Referencia;

import java.util.List;

@Dao
public interface ClienteDao {

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    public void insert(List<Cliente> clientes);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    long insert(Cliente cliente);

    @Query("DELETE FROM "+Cliente.TABLE_NAME)
    public void deleteAll();

    @Query("SELECT * FROM "+Cliente.TABLE_NAME+" ORDER BY id_cliente DESC")
    public LiveData<List<Cliente>> getAll();

    @Query("SELECT * FROM "+Cliente.TABLE_NAME)
    public List<Cliente> getAll_();


    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insertReferencias(List<Referencia> referencias);

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insertReferencia(Referencia referencia);

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insertArchivos(List<Archivo> archivos);

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insertArchivo(Archivo archivo);

    @Query("DELETE FROM "+Archivo.TABLE_NAME)
    void deleteArchivos();

    @Query("DELETE FROM "+Archivo.TABLE_NAME+" WHERE sincronizado=1 ")
    void deleteArchivosSincronizados();

    @Query("DELETE FROM "+Referencia.TABLE_NAME)
    void deleteReferencias();

    @Query("DELETE FROM "+Referencia.TABLE_NAME+" WHERE sincronizada=1 ")
    void deleteReferenciasSincronizadas();

    @Query("SELECT * FROM "+Cliente.TABLE_NAME+" WHERE id_cliente != :id ")
    public List<Cliente> getAll_notId(int id);

    @Query("SELECT nombre FROM "+Cliente.TABLE_NAME+ " WHERE id_cliente=:id")
    String getNombre(int id);

    @Query("SELECT * FROM "+ Cliente.TABLE_NAME+" WHERE sincronizado=0")
    List<Cliente> getNoSincronizados();

    @Query("DELETE FROM "+Cliente.TABLE_NAME+" WHERE sincronizado=1")
    public void deleteAllSincronizados();

    @Query("SELECT * FROM "+ Archivo.TABLE_NAME+" WHERE sincronizado=0 AND id_cliente=:id_cliente")
    List<Archivo> getArchivosNoSincronizados(int id_cliente);

    @Query("SELECT * FROM "+Referencia.TABLE_NAME+" WHERE sincronizada=0 AND id_cliente=:id_cliente")
    List<Referencia> getReferenciasNoSincronizadas(int id_cliente);


    @Query("DELETE FROM "+Archivo.TABLE_NAME+" WHERE id_cliente=:id_cliente")
    void deleteArchivosByCliente(int id_cliente);

    @Query("DELETE FROM "+Referencia.TABLE_NAME+" WHERE id_cliente=:id_cliente")
    void deleteReferenciaByCliente(int id_cliente);

    @Delete
    void delete(Cliente cliente);

    @Query("SELECT COUNT(*) FROM "+Cliente.TABLE_NAME+" WHERE dui=:dui AND nit=:nit")
    int existeCliente(String dui, String nit);

    @Query("SELECT * FROM "+Cliente.TABLE_NAME+" WHERE id_cliente=:id")
    LiveData<Cliente> getClienteLive(int id);



    @Query("SELECT * FROM "+ Archivo.TABLE_NAME+" WHERE id_cliente=:id_cliente")
    List<Archivo> getArchivosByCliente(int id_cliente);

    @Query("SELECT * FROM "+Referencia.TABLE_NAME+" WHERE id_cliente=:id_cliente")
    List<Referencia> getReferenciasByCliente(int id_cliente);

    @Query("UPDATE "+Cliente.TABLE_NAME+" SET sincronizado=1, id_cliente=:nuevo_id WHERE id_cliente=:id_cliente")
    void updateSync(int nuevo_id, int id_cliente);


    @Query("SELECT * FROM "+ Archivo.TABLE_NAME+" WHERE sincronizado=0")
    List<Archivo> getArchivosNoSync();

    @Query("SELECT * FROM "+Referencia.TABLE_NAME+" WHERE sincronizada=0")
    List<Referencia> getReferenciasNoSync();

    @Delete
    void deleteArchivo(Archivo archivo);

}
