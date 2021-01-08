package com.c3rberuss.crediapp.entities;

import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;

public class PlanRequisito {

    @Embedded Plan plan;
    @Relation(entity = Requisito.class, parentColumn = "id", entityColumn = "id_plan")
    List<Requisito> requisitos;

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public List<Requisito> getRequisitos() {
        return requisitos;
    }

    public void setRequisitos(List<Requisito> requisitos) {
        this.requisitos = requisitos;
    }
}
