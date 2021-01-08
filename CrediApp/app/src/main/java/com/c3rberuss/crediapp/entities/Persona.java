package com.c3rberuss.crediapp.entities;

public class Persona {

    /**
     * id : 1
     * nombre : DIARIA
     * proporcion : 20
     */

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
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getProporcion() {
        return proporcion;
    }

    public void setProporcion(int proporcion) {
        this.proporcion = proporcion;
    }
}
