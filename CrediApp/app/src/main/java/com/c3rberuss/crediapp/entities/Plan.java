package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;

import java.util.List;

@Entity(tableName = Plan.TABLE_NAME)
public class Plan {

    @Ignore public static final String TABLE_NAME = "planes";

    @PrimaryKey
    private int id;
    private String nombre;
    private double porcentaje;
    private double desde;
    private double hasta;
    private int frecuencia;
    private int dias_mora;
    private double mora;
    @SerializedName("contrato")
    private double valor_contrato;
    private int modcontrato;
    private boolean solointeres;

    @Ignore
    private Frecuencia frecuencia_;

    @Ignore
    private List<Requisito> requisitos;

    @Ignore
    private List<PlanRequisito2> planes_requisitos;

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

    public double getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(double porcentaje) {
        this.porcentaje = porcentaje;
    }

    public double getDesde() {
        return desde;
    }

    public void setDesde(double desde) {
        this.desde = desde;
    }

    public double getHasta() {
        return hasta;
    }

    public void setHasta(double hasta) {
        this.hasta = hasta;
    }

    public int getFrecuencia() {
        return frecuencia;
    }

    public void setFrecuencia(int frecuencia) {
        this.frecuencia = frecuencia;
    }

    public List<Requisito> getRequisitos() {
        return requisitos;
    }

    public void setRequisitos(List<Requisito> requisitos) {
        this.requisitos = requisitos;
    }

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public double getMora() {
        return mora;
    }

    public void setMora(double mora) {
        this.mora = mora;
    }

    public double getValor_contrato() {
        return valor_contrato;
    }

    public void setValor_contrato(double valor_contrato) {
        this.valor_contrato = valor_contrato;
    }

    public int getModcontrato() {
        return modcontrato;
    }

    public void setModcontrato(int modcontrato) {
        this.modcontrato = modcontrato;
    }

    public boolean isSolointeres() {
        return solointeres;
    }

    public void setSolointeres(boolean solointeres) {
        this.solointeres = solointeres;
    }

    public Frecuencia getFrecuencia_() {
        return frecuencia_;
    }

    public void setFrecuencia_(Frecuencia frecuencia_) {
        this.frecuencia_ = frecuencia_;
    }

    public List<PlanRequisito2> getPlanes_requisitos() {
        return planes_requisitos;
    }

    public void setPlanes_requisitos(List<PlanRequisito2> planes_requisitos) {
        this.planes_requisitos = planes_requisitos;
    }
}
