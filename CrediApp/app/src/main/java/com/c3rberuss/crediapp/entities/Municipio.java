package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(tableName = Municipio.TABLE_NAME)
public class Municipio {

    @Ignore
    public static final String TABLE_NAME = "municipio";

    @PrimaryKey
    private int id_municipio;
    private int id_departamento_municipio;
    private String nombre_municipio;

    public int getId_municipio() {
        return id_municipio;
    }

    public void setId_municipio(int id_municipio) {
        this.id_municipio = id_municipio;
    }

    public int getId_departamento_municipio() {
        return id_departamento_municipio;
    }

    public void setId_departamento_municipio(int id_departamento_municipio) {
        this.id_departamento_municipio = id_departamento_municipio;
    }

    public String getNombre_municipio() {
        return nombre_municipio.toUpperCase();
    }

    public void setNombre_municipio(String nombre_municipio) {
        this.nombre_municipio = nombre_municipio;
    }
}
