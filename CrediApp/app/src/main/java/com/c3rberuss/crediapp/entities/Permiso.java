package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = Permiso.TABLE_NAME)
public class Permiso {

    public static final String TABLE_NAME = "permiso";

    @PrimaryKey
    private int id_modulo;
    private int id_usuario;
    private String nombre;

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_modulo() {
        return id_modulo;
    }

    public void setId_modulo(int id_modulo) {
        this.id_modulo = id_modulo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
