package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;

import com.google.gson.annotations.SerializedName;

import static androidx.room.ForeignKey.CASCADE;

@Entity(
        tableName = Platillo.TABLE_NAME
        //  indices = {@Index("id_categoria")},
        //foreignKeys = @ForeignKey(entity = Categoria.class, parentColumns = "id", childColumns = "id_categoria", onDelete = CASCADE)
)
public class Platillo {

    @Ignore
    public static  final String TABLE_NAME = "platillo";

    @PrimaryKey
    @SerializedName("id_producto")
    private int id_platillo;
    @SerializedName("descripcion")
    private String nombre;
    @SerializedName("descrip_completa")
    private String descripcion;
    private String imagen;
    private double precio;
    private int id_categoria;

    public int getId_platillo() {
        return id_platillo;
    }

    public void setId_platillo(int id) {
        this.id_platillo = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
}
