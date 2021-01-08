package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(tableName = PlanRequisito2.TABLE_NAME)
public class PlanRequisito2 {

    @Ignore public static final String TABLE_NAME="plan_requisito";

    @PrimaryKey
    private int id;
    private int id_plan;
    private int id_requisito;
    private int cantidad;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_plan() {
        return id_plan;
    }

    public void setId_plan(int id_plan) {
        this.id_plan = id_plan;
    }

    public int getId_requisito() {
        return id_requisito;
    }

    public void setId_requisito(int id_requisito) {
        this.id_requisito = id_requisito;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
