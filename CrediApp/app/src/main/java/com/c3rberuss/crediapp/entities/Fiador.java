package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;

@Entity(tableName = Fiador.TABLE_NAME)
public class Fiador {

    @Ignore public static  final String TABLE_NAME = "solicitud_fiador";

    @PrimaryKey(autoGenerate = true)
    @SerializedName("id")
    private int id;

    @SerializedName("id_fiador")
    private int idFiador;

    @SerializedName("actividad")
    private String actividad;
    @SerializedName("direccion")
    private String direccion;
    @SerializedName("negocio")
    private String negocio;
    @SerializedName("fecha")
    private String fecha;
    @SerializedName("id_prestamo")
    private int idPrestamo;



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
}
