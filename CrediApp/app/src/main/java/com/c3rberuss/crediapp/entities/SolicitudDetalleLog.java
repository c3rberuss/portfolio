package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = SolicitudDetalleLog.TABLE_NAME)
public class SolicitudDetalleLog implements AppVersion {
    /*
    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`, `fecha_pago`, `hora_pago`,
     `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia` FROM `prestamo_detalle` WHERE 1
    */

    @Ignore public static final String TABLE_NAME = "solicitud_detalle_log";

    @PrimaryKey(autoGenerate = true)
    private int id;

    @ColumnInfo
    @NonNull
    private int id_detalle;
    @ColumnInfo
    @NonNull
    private int id_prestamo;
    @ColumnInfo
    private int ncuota;
    @ColumnInfo
    private String correlativo;
    @ColumnInfo
    private double monto;
    @ColumnInfo
    private double saldo;
    @ColumnInfo
    private int pagado;
    @ColumnInfo
    private String fecha_pago;
    @ColumnInfo
    private String hora_pago;
    @ColumnInfo
    private double mora;
    @ColumnInfo
    private String fecha_vence;
    @ColumnInfo
    private String referencia;
    @ColumnInfo
    private int id_cobrador;
    @Ignore
    private String nombre;
    private boolean sincronizado = true;

    @ColumnInfo(name = "fecha_log")
    private String fecha;
    @ColumnInfo(name = "hora_log")
    private String hora;

    public String app_version = BuildConfig.VERSION_NAME;


    public int getId_detalle() {
        return id_detalle;
    }
    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
    }

    public int getId_prestamo() {
        return id_prestamo;
    }
    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }

    public int getId_cobrador() {
        return id_cobrador;
    }
    public void setId_cobrador(int id_cobrador) {
        this.id_cobrador = id_cobrador;
    }

    public int getNcuota() {
        return ncuota;
    }
    public void setNcuota(int ncuota) { this.ncuota = ncuota; }

    public double getMora() {
        return mora;
    }
    public void setMora(double  mora) { this.mora = mora; }

    public double getSaldo() {
        return saldo;
    }
    public void setSaldo(double  saldo) { this.saldo = saldo; }

    public double getMonto() {
        return monto;
    }
    public void setMonto(double  monto) { this. monto = monto; }

    public int getPagado() {
        return pagado;
    }
    public void setPagado(int pagado) { this.pagado = pagado; }

    public String getCorrelativo() {
        return correlativo;
    }
    public void setCorrelativo(String correlativo) {
        this.correlativo = correlativo;
    }


    public String getFecha_pago() {
        return fecha_pago;
    }
    public void setFecha_pago(String fecha_pago) {
        this.fecha_pago = fecha_pago;
    }

    public String getFecha_vence() {
        return fecha_vence;
    }
    public void setFecha_vence(String fecha_vence) {
        this.fecha_vence = fecha_vence;
    }

    public String getHora_pago() {
        return hora_pago;
    }
    public void setHora_pago(String hora_pago) {
        this.hora_pago = hora_pago;
    }


    public String getReferencia() {
        return referencia;
    }
    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }


    public static String getTableName() {
        return TABLE_NAME;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getApp_version() {
        return app_version;
    }

    public static SolicitudDetalleLog fromDetalle(SolicitudDetalle solicitudDetalle){
        final SolicitudDetalleLog solicitudDetalleLog = new SolicitudDetalleLog();

        solicitudDetalleLog.setId_detalle(solicitudDetalle.getId_detalle());
        solicitudDetalleLog.setId_prestamo(solicitudDetalle.getId_prestamo());
        solicitudDetalleLog.setNcuota(solicitudDetalle.getNcuota());
        solicitudDetalleLog.setCorrelativo(solicitudDetalle.getCorrelativo());
        solicitudDetalleLog.setMonto(solicitudDetalle.getMonto());
        solicitudDetalleLog.setSaldo(solicitudDetalle.getSaldo());
        solicitudDetalleLog.setPagado(solicitudDetalle.getPagado());
        solicitudDetalleLog.setId_cobrador(solicitudDetalle.getId_cobrador());
        solicitudDetalleLog.setFecha_pago(solicitudDetalle.getFecha_pago());
        solicitudDetalleLog.setHora_pago(solicitudDetalle.getHora_pago());
        solicitudDetalleLog.setFecha_vence(solicitudDetalle.getFecha_vence());
        solicitudDetalleLog.setMora(solicitudDetalle.getMora());
        solicitudDetalleLog.setReferencia(solicitudDetalle.getReferencia());

        solicitudDetalleLog.setFecha(Functions.getFecha());
        solicitudDetalleLog.setHora(Functions.getHora());

        return solicitudDetalleLog;
    }
}
