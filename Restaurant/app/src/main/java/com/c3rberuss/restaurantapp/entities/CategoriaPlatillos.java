package com.c3rberuss.restaurantapp.entities;

import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;

public class CategoriaPlatillos {
    @Embedded Categoria categoria;

    @Relation(entity = Platillo.class, parentColumn = "id", entityColumn = "id_categoria")
    private List<Platillo> platillos;

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public List<Platillo> getPlatillos() {
        return platillos;
    }

    public void setPlatillos(List<Platillo> platillos) {
        this.platillos = platillos;
    }
}
