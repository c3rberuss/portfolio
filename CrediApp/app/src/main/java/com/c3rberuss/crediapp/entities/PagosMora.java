package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = PagosMora.TABLE_NAME)
public class PagosMora {
    public static final String TABLE_NAME = "pagos_mora";

    @PrimaryKey(autoGenerate = true)
    private int id;

    private int id_prestamo = -1;
    private int dias_mora = 0;
    private double valor = 0.0;
    private String fecha = "0000-00-00";
    private String hora = "00:00:00";
    private int corresponde = -1;
    private boolean sincronizado = false;
    private int id_usuario = 0;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_prestamo() {
        return id_prestamo;
    }

    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public int getCorresponde() {
        return corresponde;
    }

    public void setCorresponde(int corresponde) {
        this.corresponde = corresponde;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }
}
