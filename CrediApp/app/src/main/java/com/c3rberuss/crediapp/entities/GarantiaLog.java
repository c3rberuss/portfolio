package com.c3rberuss.crediapp.entities;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = GarantiaLog.TABLE_NAME)
public class GarantiaLog {

    @Ignore public static final String TABLE_NAME = "solicitud_garantia_log";

    @PrimaryKey(autoGenerate = true)
    private int id;

    private int id_garantia;
    private int id_prestamo;
    private String fecha;
    private String descripcion;
    private String url;
    private String direccion;
    private int municipio;
    private int departamento;
    private int id_cliente;
    private String nombre;

    @ColumnInfo(name = "fecha_log")
    private String fecha_;
    private String hora;


    public int getId_garantia() {
        return id_garantia;
    }

    public void setId_garantia(int id_garantia) {
        this.id_garantia = id_garantia;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion.toUpperCase();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getDepartamento() {
        return departamento;
    }

    public void setDepartamento(int departamento) {
        this.departamento = departamento;
    }

    public int getMunicipio() {
        return municipio;
    }

    public void setMunicipio(int municipio) {
        this.municipio = municipio;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion.toUpperCase();
    }

    public int getId_prestamo() {
        return id_prestamo;
    }

    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public static String getTableName() {
        return TABLE_NAME;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public static GarantiaLog fromGarantia(Garantia garantia){
        final GarantiaLog garantiaLog = new GarantiaLog();

        garantiaLog.setId_garantia(garantia.getId_garantia());
        garantiaLog.setId_cliente(garantia.getId_cliente());
        garantiaLog.setId_prestamo(garantia.getId_prestamo());
        garantiaLog.setFecha(garantia.getFecha());
        garantiaLog.setNombre(garantia.getNombre());
        garantiaLog.setDescripcion(garantia.getDescripcion());
        garantiaLog.setUrl(garantia.getUrl());
        garantiaLog.setDepartamento(garantia.getDepartamento());
        garantiaLog.setMunicipio(garantia.getMunicipio());
        garantiaLog.setDireccion(garantia.getDireccion());

        garantiaLog.setFecha_(Functions.getFecha());
        garantiaLog.setHora(Functions.getHora());

        return garantiaLog;
    }
}
