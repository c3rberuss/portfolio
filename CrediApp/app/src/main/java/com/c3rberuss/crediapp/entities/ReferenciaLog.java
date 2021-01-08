package com.c3rberuss.crediapp.entities;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = ReferenciaLog.TABLE_NAME)
public class ReferenciaLog {

    @Ignore public static  final String TABLE_NAME = "cliente_referencia_log";

    @PrimaryKey(autoGenerate = true)
    private int id_;

    private int id;
    private int id_cliente;
    private String nombre;
    private String telefono;
    private String parentezco;
    private String fecha_registro;

    private boolean sincronizada = true;

    @ColumnInfo(name = "fecha_log")
    private String fecha;
    @ColumnInfo(name = "hora_log")
    private String hora;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre.toUpperCase();
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getParentezco() {
        return parentezco;
    }

    public void setParentezco(String parentezco) {
        this.parentezco = parentezco.toUpperCase();
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public boolean isSincronizada() {
        return sincronizada;
    }

    public void setSincronizada(boolean sincronizada) {
        this.sincronizada = sincronizada;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public int getId_() {
        return id_;
    }

    public void setId_(int id_) {
        this.id_ = id_;
    }

    public static String getTableName() {
        return TABLE_NAME;
    }

    public static ReferenciaLog fromReferencia(Referencia referencia){
        final ReferenciaLog referenciaLog = new ReferenciaLog();

        referenciaLog.setId(referencia.getId());
        referenciaLog.setId_cliente(referencia.getId_cliente());
        referenciaLog.setNombre(referencia.getNombre());
        referenciaLog.setTelefono(referencia.getTelefono());
        referenciaLog.setParentezco(referencia.getParentezco());
        referenciaLog.setFecha_registro(referencia.getFecha_registro());

        referenciaLog.setFecha(Functions.getFecha());
        referenciaLog.setHora(Functions.getHora());

        return referenciaLog;
    }

}
