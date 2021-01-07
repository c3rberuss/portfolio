package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = PlatilloFavorito.TABLE_NAME)
public class PlatilloFavorito {

    public static final String TABLE_NAME = "platillo_favorito";

    @PrimaryKey(autoGenerate = true)
    private int id;
    private int id_usuario;
    private int id_platillo;
    private boolean fav = false;
    private int id_categoria;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_platillo() {
        return id_platillo;
    }

    public void setId_platillo(int id_platillo) {
        this.id_platillo = id_platillo;
    }

    public boolean isFav() {
        return fav;
    }

    public void setFav(boolean fav) {
        this.fav = fav;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }
}
