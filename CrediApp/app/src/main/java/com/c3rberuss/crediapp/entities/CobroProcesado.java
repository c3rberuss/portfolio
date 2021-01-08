package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = CobroProcesado.TABLE_NAME)
public class CobroProcesado implements AppVersion {

    @Ignore public static final String TABLE_NAME = "cobros_procesado";

    @PrimaryKey(autoGenerate = true)
    private int id;
    private int cantidad;

    private String fecha = "0000-00-00";
    private int id_prestamo = 0;
    private int id_usuario;
    private double monto = 0.0;
    private double mora = 0.0;
    private String hora = "00:00:00";

    private boolean sincronizado = false;
    private int id_detalle = 0;
    private boolean abono = false;
    private boolean recuperacion = false;
    private String cliente;
    private String cuota;
    private boolean soloMora = false;
    private boolean pago_mora = false;


    private String referencia;



    public String app_version = BuildConfig.VERSION_NAME;

    public CobroProcesado(int cantidad, int id_prestamo, int id_usuario) {
        this.cantidad = cantidad;
        this.fecha = Functions.getFecha();
        this.hora = Functions.getHora();
        this.id_prestamo = id_prestamo;
        this.id_usuario = id_usuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getId_prestamo() {
        return id_prestamo;
    }

    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public double getMora() {
        return mora;
    }

    public void setMora(double mora) {
        this.mora = mora;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getApp_version() {
        return app_version;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public int getId_detalle() {
        return id_detalle;
    }

    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
    }

    public boolean isAbono() {
        return abono;
    }

    public void setAbono(boolean abono) {
        this.abono = abono;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getCuota() {
        return cuota;
    }

    public void setCuota(String cuota) {
        this.cuota = cuota;
    }

    public boolean isRecuperacion() {
        return recuperacion;
    }

    public void setRecuperacion(boolean recuperacion) {
        this.recuperacion = recuperacion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public boolean isSoloMora() {
        return soloMora;
    }

    public void setSoloMora(boolean soloMora) {
        this.soloMora = soloMora;
    }

    public boolean isPago_mora() {
        return pago_mora;
    }

    public void setPago_mora(boolean pago_mora) {
        this.pago_mora = pago_mora;
    }
}
