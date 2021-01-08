package com.c3rberuss.crediapp.entities;


import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;

public class DepartamentoMunicipio {

    @Embedded Departamento departamento;

    @Relation(entity = Municipio.class, parentColumn = "id_departamento", entityColumn = "id_departamento_municipio")
    private List<Municipio> municipios;

    public Departamento getDepartamento() {
        return departamento;
    }

    public void setDepartamento(Departamento departamento) {
        this.departamento = departamento;
    }

    public List<Municipio> getMunicipios() {
        return municipios;
    }

    public void setMunicipios(List<Municipio> municipios) {
        this.municipios = municipios;
    }
}
