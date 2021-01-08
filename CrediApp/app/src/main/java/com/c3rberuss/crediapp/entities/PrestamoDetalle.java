package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;

import java.io.Serializable;

@Entity(tableName = PrestamoDetalle.TABLE_NAME)
public class PrestamoDetalle implements AppVersion, Serializable {
    /*
    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`, `fecha_pago`, `hora_pago`,
     `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia` FROM `prestamo_detalle` WHERE 1
    */

    @Ignore public static final String TABLE_NAME = "prestamo_detalle";

    @PrimaryKey
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
    private double monto = 0.0;
    @ColumnInfo
    private double saldo;
    @ColumnInfo
    private int pagado;
    @ColumnInfo
    private int id_cobrador;
    @ColumnInfo
    private String fecha_pago;
    @ColumnInfo
    private String hora_pago;
    @ColumnInfo
    private String fecha_vence;
    @ColumnInfo
    private double mora = 0.0;
    @ColumnInfo
    private String referencia;
    private double efectivo;

    private double abono;
    private double monto_abono = 0.0;

    @Ignore
    private String nombre;

    @Ignore
    private boolean tiene_mora = false;

    private boolean sincronizado = true;
    private boolean abonado = false;

    @ColumnInfo
    private String hora_abono;
    @ColumnInfo
    private String fecha_abono;

    public String app_version = BuildConfig.VERSION_NAME;

    @Ignore
    private int dias_mora = 0;

    @Ignore
    private boolean solo_mora = false;

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

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public String getApp_version() {
        return app_version;
    }

    public double getAbono() {
        return abono;
    }

    public void setAbono(double abono) {
        this.abono = abono;
    }

    public boolean isAbonado() {
        return abonado;
    }

    public void setAbonado(boolean abonado) {
        this.abonado = abonado;
    }

    public double getMonto_abono() {
        return monto_abono;
    }

    public void setMonto_abono(double monto_abono) {
        this.monto_abono = monto_abono;
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

    public boolean isSolo_mora() {
        return solo_mora;
    }

    public void setSolo_mora(boolean solo_mora) {
        this.solo_mora = solo_mora;
    }
}
