package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;
import androidx.room.Relation;

import com.google.gson.annotations.SerializedName;

import static androidx.room.ForeignKey.CASCADE;
import static androidx.room.ForeignKey.NO_ACTION;

@Entity(tableName = PedidoDetalle.TABLE_NAME)
public class PedidoDetalle {

    @Ignore
    public static  final String TABLE_NAME = "pedido_detalle";

    @PrimaryKey(autoGenerate = true)
    private int id;
    @SerializedName("id_platillo")
    private int id_platillo_detalle;
    @SerializedName("id_pedido_app")
    private int id_pedido;
    private double subtotal;
    private int cantidad;
    private String nota;

    @Ignore
    private Platillo platillo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_platillo_detalle() {
        return id_platillo_detalle;
    }

    public void setId_platillo_detalle(int id_platillo) {
        this.id_platillo_detalle = id_platillo;
    }

    public int getId_pedido() {
        return id_pedido;
    }

    public void setId_pedido(int id_pedido) {
        this.id_pedido = id_pedido;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Platillo getPlatillo() {
        return platillo;
    }

    public void setPlatillo(Platillo platillo) {
        this.platillo = platillo;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }
}
