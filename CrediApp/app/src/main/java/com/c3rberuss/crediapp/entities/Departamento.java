package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.util.List;

@Entity(tableName = Departamento.TABLE_NAME)
public class Departamento {

    @Ignore
    public static final String TABLE_NAME = "departamento";

    @PrimaryKey
    private int id_departamento;
    private String nombre_departamento;

    @Ignore
    private List<Municipio> municipios;

    public int getId_departamento() {
        return id_departamento;
    }

    public void setId_departamento(int id_departamento) {
        this.id_departamento = id_departamento;
    }

    public String getNombre_departamento() {
        return nombre_departamento.toUpperCase();
    }

    public void setNombre_departamento(String nombre_departamento) {
        this.nombre_departamento = nombre_departamento;
    }

    public List<Municipio> getMunicipios() {
        return municipios;
    }

    public void setMunicipios(List<Municipio> municipios) {
        this.municipios = municipios;
    }
}
