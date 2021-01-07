package com.c3rberuss.restaurantapp.entities;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;
import androidx.room.Relation;
import androidx.room.TypeConverters;

import com.c3rberuss.restaurantapp.db.converter.DateConverter;
import com.google.gson.annotations.SerializedName;

import java.util.Date;
import java.util.List;

import static androidx.room.ForeignKey.CASCADE;

@Entity(tableName = Pedido.TABLE_NAME)
@TypeConverters({DateConverter.class})

public class Pedido {

    @Ignore
    public static  final String TABLE_NAME = "pedido";

    @PrimaryKey(autoGenerate = true)
    @SerializedName("id_pedido_app")
    private int id;
    @SerializedName("fecha_")
    private Date fecha_;

    @Ignore
    private String fecha;

    @SerializedName("procesado")
    private boolean procesada = false;
    private int id_usuario;
    private double total;

    public Pedido(){
        this.fecha_ = new Date();
    }

    @Ignore
    @Relation(entity = PedidoDetalle.class, parentColumn = "id", entityColumn = "id_pedido" )
    private List<PedidoDetalle> detalle;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public boolean isProcesada() {
        return procesada;
    }

    public void setProcesada(boolean procesada) {
        this.procesada = procesada;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public List<PedidoDetalle> getDetalle() {
        return detalle;
    }

    public void setDetalle(List<PedidoDetalle> detalle) {
        this.detalle = detalle;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getFecha() {
        return fecha;
    }

    public Date getFecha_() {
        return fecha_;
    }

    public void setFecha_(Date fecha_) {
        this.fecha_ = fecha_;
    }
}
