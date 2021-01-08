package com.c3rberuss.crediapp.entities;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.utils.Functions;
import com.google.gson.annotations.SerializedName;

@Entity(tableName = FiadorLog.TABLE_NAME)
public class FiadorLog {

    @Ignore public static  final String TABLE_NAME = "solicitud_fiador_log";

    @PrimaryKey(autoGenerate = true)
    private int id_;

    @SerializedName("id")
    private int id;
    @SerializedName("id_prestamo")
    private int idPrestamo;
    @SerializedName("id_fiador")
    private int idFiador;
    @SerializedName("fecha")
    private String fecha;
    @SerializedName("negocio")
    private String negocio;
    @SerializedName("direccion")
    private String direccion;
    @SerializedName("actividad")
    private String actividad;


    @ColumnInfo(name = "fecha_log")
    private String fecha_;
    @ColumnInfo(name = "hora_log")
    private String hora;

    private boolean tieneNegocio;

    private boolean sincronizado = true;

    public String getActividad() {
        return actividad;
    }

    public void setActividad(String actividad) {
        this.actividad = actividad.toUpperCase();
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion.toUpperCase();
    }

    public String getNegocio() {
        return negocio;
    }

    public void setNegocio(String negocio) {
        this.negocio = negocio.toUpperCase();
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getIdFiador() {
        return idFiador;
    }

    public void setIdFiador(int idFiador) {
        this.idFiador = idFiador;
    }

    public int getIdPrestamo() {
        return idPrestamo;
    }

    public void setIdPrestamo(int idPrestamo) {
        this.idPrestamo = idPrestamo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isTieneNegocio() {
        return tieneNegocio;
    }

    public void setTieneNegocio(boolean tieneNegocio) {
        this.tieneNegocio = tieneNegocio;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public String getFecha_() {
        return fecha_;
    }

    public void setFecha_(String fecha_) {
        this.fecha_ = fecha_;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public int getId_() {
        return id_;
    }

    public void setId_(int id_) {
        this.id_ = id_;
    }

    public static String getTableName() {
        return TABLE_NAME;
    }

    public static FiadorLog fromFiador(Fiador fiador){
        final FiadorLog fiadorLog = new FiadorLog();

        fiadorLog.setIdFiador(fiador.getIdFiador());
        fiadorLog.setActividad(fiador.getActividad());
        fiadorLog.setDireccion(fiador.getDireccion());
        fiadorLog.setNegocio(fiador.getNegocio());
        fiadorLog.setFecha(fiador.getFecha());
        fiadorLog.setIdPrestamo(fiador.getIdPrestamo());
        fiadorLog.setId(fiador.getId());

        fiadorLog.setFecha_(Functions.getFecha());
        fiadorLog.setHora(Functions.getHora());

        return fiadorLog;
    }
}
