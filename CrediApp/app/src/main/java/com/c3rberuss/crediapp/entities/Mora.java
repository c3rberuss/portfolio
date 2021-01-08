package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;


@Entity(tableName = Mora.TABLE_NAME)
public class Mora {

    @Ignore()
    public final static String TABLE_NAME = "mora";

    @PrimaryKey
    @SerializedName("id_mora")
    private int id_mora;

    @SerializedName("mora")
    private double mora;
    @SerializedName("dias_mora")
    private int dias_mora;
    @SerializedName("frecuencia")
    private int frecuencia;
    @SerializedName("hasta")
    private double hasta;
    @SerializedName("desde")
    private double desde;

    public double getMora() {
        return mora;
    }

    public void setMora(double mora) {
        this.mora = mora;
    }

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public int getFrecuencia() {
        return frecuencia;
    }

    public void setFrecuencia(int frecuencia) {
        this.frecuencia = frecuencia;
    }

    public double getHasta() {
        return hasta;
    }

    public void setHasta(double hasta) {
        this.hasta = hasta;
    }

    public double getDesde() {
        return desde;
    }

    public void setDesde(double desde) {
        this.desde = desde;
    }

    public int getId_mora() {
        return id_mora;
    }

    public void setId_mora(int id_mora) {
        this.id_mora = id_mora;
    }
}
