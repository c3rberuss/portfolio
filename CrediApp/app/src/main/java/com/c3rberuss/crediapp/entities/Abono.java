package com.c3rberuss.crediapp.entities;

import com.c3rberuss.crediapp.utils.Functions;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(tableName = Abono.TABLE_NAME)
public class Abono {

    @Ignore
    public static final String TABLE_NAME = "abonos";

    @PrimaryKey(autoGenerate = true)
    private int id;
    private int id_detalle;
    private String fecha = Functions.getFecha();
    private String hora = Functions.getHora();
    private double valor = 0.0;
    private String referencia;
    private boolean sincronizado = false;

    private int usuario_abono;
    private int caja = 0;
    private int id_prestamo = 0;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_detalle() {
        return id_detalle;
    }

    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
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

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public int getUsuario_abono() {
        return usuario_abono;
    }

    public void setUsuario_abono(int usuario_abono) {
        this.usuario_abono = usuario_abono;
    }

    public int getCaja() {
        return caja;
    }

    public void setCaja(int caja) {
        this.caja = caja;
    }

    public int getId_prestamo() {
        return id_prestamo;
    }

    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }
}
