package com.c3rberuss.crediapp.database.dao;


import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.entities.SolicitudCredito;

import java.util.List;

@Dao
public interface PrestamoDao {

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+ " WHERE estado=1 ORDER BY date(fecha) DESC")
    List<Prestamo> getAllPrestamo();

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+ " ORDER BY date(fecha) DESC")
   LiveData<List<Prestamo>> getAllPrestamoLive();

    @Query("SELECT * FROM prestamo WHERE id_prestamo LIKE :id_prestamo")
    int getIdPrestamo(int id_prestamo);

    @Query("SELECT * FROM prestamo WHERE id_prestamo LIKE :id_prestamo")
    boolean getExisteIdPrestamo(int id_prestamo);

    String sql2="SELECT nombre FROM prestamo WHERE id_prestamo LIKE :id_prestamo";
    @Query(sql2)
    String getNombreCliente(int id_prestamo);

    String sql3="SELECT * FROM prestamo WHERE id_prestamo LIKE :id_prestamo";
    @Query(sql3)
    List<Prestamo> getByIdPrestamo(int id_prestamo);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertPrestamo(Prestamo prestamo);

    @Delete
    void deletePrestamo(Prestamo prestamo);

    @Update
    void updatePrestamo(Prestamo prestamo);

    String sql4="UPDATE prestamo SET  saldo=saldo-:totalAbonoCuotas," +
            " abono=abono+:totalAbonoCuotas, ultimo_pago=:ultimo_pago, id_cobrador=:id_cobrador, sincronizado=0"+
            " WHERE id_prestamo=:id_prestamo";
    @Query(sql4)
    void updateByIdPrestamo(int id_prestamo, double totalAbonoCuotas, String ultimo_pago, int id_cobrador);


    @Query("SELECT * FROM planes WHERE id LIKE :id")
    boolean getExisteIdPlan(int id);

    String sql5="SELECT * FROM planes WHERE id LIKE :id";
    @Query(sql5)
    List<Plan> getListByIdPlan(int id);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertPlan(Plan plan);

    String sql6="SELECT plaan FROM prestamo WHERE id_prestamo LIKE :id_prestamo";
    @Query(sql6)
    int getPlaan(int id_prestamo);


    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insert(List<Prestamo> prestamos);

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insert(Prestamo prestamos);

    @Query("DELETE FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado=1")
    void delete();

    @Query("DELETE FROM "+Prestamo.TABLE_NAME)
    void deleteAll2();

    @Query("DELETE FROM "+ Prestamo.TABLE_NAME +" WHERE abonado = 0")
    void deleteAll();


    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado=0")
    List<Prestamo> getPrestamosNoSincronizados();

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado=0 AND abonado=1")
    List<Prestamo> getPrestamosNoSincronizadosAbonados();

    @Query("SELECT COUNT(*) FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado=0")
    LiveData<Integer> getPendientesSincronizacion();


    @Query("SELECT p.* FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
            "JOIN "+Prestamo.TABLE_NAME+" AS p ON pd.id_prestamo = p.id_prestamo\n" +
            "JOIN "+ Cliente.TABLE_NAME +" AS c ON p.id_cliente = c.id_cliente\n" +
            "WHERE pd.pagado != 1 GROUP BY p.id_cliente ORDER BY date(pd.fecha_vence) DESC\n" +
            "\n")
    List<Prestamo> getAllPrestamos();

    @Query("SELECT p.* FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
            "JOIN "+Prestamo.TABLE_NAME+" AS p ON pd.id_prestamo = p.id_prestamo\n" +
            "JOIN "+ Cliente.TABLE_NAME +" AS c ON p.id_cliente = c.id_cliente\n" +
            "WHERE date(pd.fecha_vence) < date(:date) AND p.estado=1 AND pd.pagado != 1 GROUP BY p.id_cliente ORDER BY date(pd.fecha_vence) DESC\n" +
            "\n")
    List<Prestamo> getPrestamosVencidos(String date);


    @Query("SELECT p.* FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
            "JOIN "+Prestamo.TABLE_NAME+" AS p ON pd.id_prestamo = p.id_prestamo\n" +
            "JOIN "+ Cliente.TABLE_NAME +" AS c ON p.id_cliente = c.id_cliente\n" +
            "WHERE date(pd.fecha_vence) < date(:date) AND pd.pagado != 1 " +
            "GROUP BY p.id_cliente ORDER BY date(pd.fecha_vence) DESC\n LIMIT 25 OFFSET :offset" +
            "\n")
    List<Prestamo> getPrestamosVencidosPaginate(String date, int offset);

    @Query("SELECT p.* FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
            "JOIN "+Prestamo.TABLE_NAME+" AS p ON pd.id_prestamo = p.id_prestamo\n" +
            "JOIN "+ Cliente.TABLE_NAME +" AS c ON p.id_cliente = c.id_cliente\n" +
            "WHERE date(pd.fecha_vence) = date(:date) AND p.estado=1 AND pd.pagado != 1 GROUP BY p.id_cliente ORDER BY date(pd.fecha_vence) DESC\n" +
            "\n")
    List<Prestamo> getPrestamosHoy(String date);

 @Query("SELECT p.* FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
         "JOIN "+Prestamo.TABLE_NAME+" AS p ON pd.id_prestamo = p.id_prestamo\n" +
         "JOIN "+ Cliente.TABLE_NAME +" AS c ON p.id_cliente = c.id_cliente\n" +
         "WHERE date(pd.fecha_vence) = date(:date) AND pd.pagado != 1 GROUP BY p.id_cliente ORDER BY date(pd.fecha_vence) DESC\n" +
         "\n")
LiveData<List<Prestamo>> getPrestamosHoyLive(String date);


    @Query("SELECT COUNT(*) FROM "+PrestamoDetalle.TABLE_NAME+" AS pd\n" +
            "WHERE date( pd.fecha_vence) = date(:date) AND pd.pagado != 1" +
            "\n")
    LiveData<Integer> getCountPrestamosPendientes(String date);

    @Query("select (SELECT count(*) FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado = 0 AND abonado=0)+\n" +
            "(SELECT count(*) FROM "+Prestamo.TABLE_NAME+" WHERE sincronizado = 0 AND abonado=1) +\n" +
            "(SELECT count(*) FROM "+ SolicitudCredito.TABLE_NAME +" WHERE sincronizada = 0 AND refinanciamiento=0) +" +
            "(SELECT count(*) FROM "+ Cliente.TABLE_NAME +" WHERE sincronizado = 0) +" +
            "(SELECT count(*) FROM "+ SolicitudCredito.TABLE_NAME +" WHERE sincronizada = 0 AND refinanciamiento=1) as sum")
    LiveData<Integer> getCountNoSincronizado();

    @Query("SELECT COUNT(*) FROM "+Prestamo.TABLE_NAME+" WHERE id_cliente=:id_cliente ")
    int getPrestamoAprobado(int id_cliente);

    @Query("SELECT finaal FROM "+Prestamo.TABLE_NAME+" WHERE id_prestamo=:id_prestamo ")
    double getMontoFinal(int id_prestamo);

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+" WHERE abono>=saldo")
    LiveData<List<Prestamo>> getCandidatosRefinanciamiento();

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+" WHERE id_prestamo=:id_prestamo")
    LiveData<Prestamo> getPrestamo(int id_prestamo);

    @Query("SELECT * FROM "+Prestamo.TABLE_NAME+" WHERE id_prestamo=:id_prestamo")
    Prestamo getPrestamo_(int id_prestamo);

    @Query("SELECT plaan FROM "+Prestamo.TABLE_NAME+" WHERE id_prestamo=:id_prestamo LIMIT 1 ")
    int getIdPlan(int id_prestamo);

    @Query("SELECT COUNT(*) FROM prestamo WHERE id_prestamo = :id_prestamo")
    int getById(int id_prestamo);

    @Query("SELECT * FROM "+Mora.TABLE_NAME+" WHERE :monto BETWEEN desde AND hasta AND frecuencia=:frecuencia")
    Mora getDatosMoraPrestamo(double monto, int frecuencia);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertMoras(List<Mora> moras);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void insertMora(Mora mora);

    @Query("DELETE FROM "+ Mora.TABLE_NAME)
    public void deleteAllMora();

}
