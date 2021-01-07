package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;

@Entity(tableName = Usuario.TABLE_NAME)
public class Usuario {

    @Ignore
    public static  final String TABLE_NAME = "usuario";

    @PrimaryKey
    private int id;
    private String nombre;
    private String telefono;
    private String correo;
    private String pwd;
    private boolean activo = false;
    private boolean fb = false;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public boolean isFb() {
        return fb;
    }

    public void setFb(boolean fb) {
        this.fb = fb;
    }
}
