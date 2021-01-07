package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;

import java.util.List;

@Entity(tableName = Categoria.TABLE_NAME)
public class Categoria{

    @Ignore
    public static  final String TABLE_NAME = "categoria_platillo";

    @PrimaryKey
    @SerializedName("id_categoria")
    private int id;
    private String nombre;
    @SerializedName("img")
    private String image;

    @Ignore
    private List<Platillo> productos;

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

    public List<Platillo> getProductos() {
        return productos;
    }

    public void setProductos(List<Platillo> productos) {
        this.productos = productos;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
