package com.c3rberuss.crediapp.database.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import com.c3rberuss.crediapp.entities.ArchivoLog;
import com.c3rberuss.crediapp.entities.ClienteLog;
import com.c3rberuss.crediapp.entities.FiadorLog;
import com.c3rberuss.crediapp.entities.GarantiaLog;
import com.c3rberuss.crediapp.entities.PrestamoDetalleLog;
import com.c3rberuss.crediapp.entities.PrestamoLog;
import com.c3rberuss.crediapp.entities.ReferenciaLog;
import com.c3rberuss.crediapp.entities.SolicitudCreditoLog;
import com.c3rberuss.crediapp.entities.SolicitudDetalleLog;

import java.util.List;

@Dao
public interface LogDao {

    @Insert
    void insertSolicitud(List<SolicitudCreditoLog> solicitudCreditoLogs);

    @Insert
    void insertSolicitud(SolicitudCreditoLog solicitudCreditoLogs);

    @Insert
    void insertSolictudDetalle(List<SolicitudDetalleLog> solicitudDetalleLogs);

    @Insert
    void insertSolictudDetalle(SolicitudDetalleLog solicitudDetalleLogs);

    @Insert
    void insertFiador(List<FiadorLog> fiadorLogs);

    @Insert
    void insertFiador(FiadorLog fiadorLog);

    @Insert
    void insertCliente(List<ClienteLog> clienteLogs);

    @Insert
    void insertCliente(ClienteLog clienteLog);

    @Insert
    void insertArchivo(List<ArchivoLog> archivoLogs);

    @Insert
    void insertArchivo(ArchivoLog archivoLog);

    @Insert
    void insertGarantia(List<GarantiaLog> garantias);

    @Insert
    void insertGarantia(GarantiaLog garantia);

    @Insert
    void insertPrestamoDetalle(List<PrestamoDetalleLog> prestamoDetalleLogs);

    @Insert
    void insertPrestamoDetalle(PrestamoDetalleLog prestamoDetalleLog);

    @Insert
    void insertPrestamo(List<PrestamoLog> prestamoLogs);

    @Insert
    void insertPrestamo(PrestamoLog prestamoLog);

    @Insert
    void insertReferencia(List<ReferenciaLog> prestamoLogs);

    @Insert
    void insertReferencia(ReferenciaLog prestamoLog);




    @Query("SELECT * FROM "+PrestamoLog.TABLE_NAME)
    List<PrestamoLog> getPrestamos();

    @Query("SELECT * FROM "+PrestamoDetalleLog.TABLE_NAME)
    List<PrestamoDetalleLog> getPrestamosDetalle();

    @Query("SELECT * FROM "+FiadorLog.TABLE_NAME)
    List<FiadorLog> getFiadores();

    @Query("SELECT * FROM "+ClienteLog.TABLE_NAME)
    List<ClienteLog> getClientes();

    @Query("SELECT * FROM "+ArchivoLog.TABLE_NAME)
    List<ArchivoLog> getArchivos();

    @Query("SELECT * FROM "+GarantiaLog.TABLE_NAME)
    List<GarantiaLog> getGarantias();

    @Query("SELECT * FROM "+ReferenciaLog.TABLE_NAME)
    List<ReferenciaLog> getReferencias();

    @Query("SELECT * FROM "+SolicitudCreditoLog.TABLE_NAME)
    List<SolicitudCreditoLog> getSolicitudes();

    @Query("SELECT * FROM "+SolicitudDetalleLog.TABLE_NAME)
    List<SolicitudDetalleLog> getSolicitudesDetalle();

    @Query("SELECT MIN(saldo) FROM "+PrestamoLog.TABLE_NAME+" WHERE id_prestamo=:id_prestamo")
    double getSaldo(int id_prestamo);
    
}
