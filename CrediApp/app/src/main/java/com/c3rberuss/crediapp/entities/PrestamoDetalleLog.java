package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = PrestamoDetalleLog.TABLE_NAME)
public class PrestamoDetalleLog implements AppVersion {
    /*
    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`, `fecha_pago`, `hora_pago`,
     `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia` FROM `prestamo_detalle` WHERE 1
    */

    @Ignore public static final String TABLE_NAME = "prestamo_detalle_log";

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
    private double efectivo;

    private double abono;

    private double monto_abono = 0.0;

    @ColumnInfo(name = "fecha_log")
    private String fecha;
    @ColumnInfo(name = "hora_log")
    private String hora;

    @ColumnInfo
    private String hora_abono;
    @ColumnInfo
    private String fecha_abono;


    @Ignore
    private String nombre;
    @ColumnInfo
    private int id_cobrador;

    public String app_version = BuildConfig.VERSION_NAME;

    @Ignore
    private boolean tiene_mora = false;

    private boolean sincronizado = true;

    public boolean isAbonado() {
        return abonado;
    }

    public void setAbonado(boolean abonado) {
        this.abonado = abonado;
    }

    private boolean abonado = false;

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

    public double getEfectivo() {
        return efectivo;
    }

    public void setEfectivo(double efectivo) {
        this.efectivo = efectivo;
    }

    public boolean isTiene_mora() {
        return tiene_mora;
    }

    public void setTiene_mora(boolean tiene_mora) {
        this.tiene_mora = tiene_mora;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getApp_version() {
        return app_version;
    }

    public String getHora_abono() {
        return hora_abono;
    }

    public void setHora_abono(String hora_abono) {
        this.hora_abono = hora_abono;
    }

    public String getFecha_abono() {
        return fecha_abono;
    }

    public void setFecha_abono(String fecha_abono) {
        this.fecha_abono = fecha_abono;
    }

    public static PrestamoDetalleLog fromPrestamoDetalle(PrestamoDetalle prestamoDetalle){
        final PrestamoDetalleLog prestamoDetalleLog = new PrestamoDetalleLog();

        prestamoDetalleLog.setId_detalle(prestamoDetalle.getId_detalle());
        prestamoDetalleLog.setId_prestamo(prestamoDetalle.getId_prestamo());
        prestamoDetalleLog.setNcuota(prestamoDetalle.getNcuota());
        prestamoDetalleLog.setCorrelativo(prestamoDetalle.getCorrelativo());
        prestamoDetalleLog.setMonto(prestamoDetalle.getMonto());
        prestamoDetalleLog.setSaldo(prestamoDetalle.getSaldo());
        prestamoDetalleLog.setPagado(prestamoDetalle.getPagado());
        prestamoDetalleLog.setId_cobrador(prestamoDetalle.getId_cobrador());
        prestamoDetalleLog.setFecha_pago(prestamoDetalle.getFecha_pago());
        prestamoDetalleLog.setHora_pago(prestamoDetalle.getHora_pago());
        prestamoDetalleLog.setFecha_vence(prestamoDetalle.getFecha_vence());
        prestamoDetalleLog.setMora(prestamoDetalle.getMora());
        prestamoDetalleLog.setReferencia(prestamoDetalle.getReferencia());
        prestamoDetalleLog.setEfectivo(prestamoDetalle.getEfectivo());
        prestamoDetalleLog.setAbonado(prestamoDetalle.isAbonado());

        prestamoDetalleLog.setFecha_abono(prestamoDetalle.getFecha_abono());
        prestamoDetalleLog.setHora_abono(prestamoDetalle.getHora_abono());

        prestamoDetalleLog.setFecha(Functions.getFecha());
        prestamoDetalleLog.setHora(Functions.getHora());

        return prestamoDetalleLog;
    }

    public double getMonto_abono() {
        return monto_abono;
    }

    public void setMonto_abono(double monto_abono) {
        this.monto_abono = monto_abono;
    }

    public double getAbono() {
        return abono;
    }

    public void setAbono(double abono) {
        this.abono = abono;
    }

    @Override
    public String toString()
    {
        return String.format("DETALLE [correlativo=%s, referencia=%s]", correlativo, referencia);
    }

}
