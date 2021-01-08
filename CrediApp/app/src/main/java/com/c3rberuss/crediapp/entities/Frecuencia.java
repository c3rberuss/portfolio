package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(tableName = Frecuencia.TABLE_NAME)
public class Frecuencia {

    @Ignore
    public static  final String TABLE_NAME = "frecuencia";

    @PrimaryKey
    private int id;
    private String nombre;
    private int proporcion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre.toUpperCase();
    }

    public void setNombre(String nombre) {
        this.nombre = nombre.toUpperCase();
    }

    public int getProporcion() {
        return proporcion;
    }

    public void setProporcion(int proporcion) {
        this.proporcion = proporcion;
    }
}
