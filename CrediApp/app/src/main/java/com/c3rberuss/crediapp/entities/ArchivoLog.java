package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = ArchivoLog.TABLE_NAME)
public class ArchivoLog {

    @Ignore public static final String TABLE_NAME = "cliente_archivo_log";

    @PrimaryKey(autoGenerate = true)
    private int id;

    private int id_archivo;
    private int id_cliente;
    private String fecha;
    private String nombre;
    private String descripcion;
    private String url;

    @ColumnInfo(name = "fecha_log")
    private String fecha_;
    @ColumnInfo(name = "hora_log")
    private String hora_;

    public int getId_archivo() {
        return id_archivo;
    }

    public void setId_archivo(int id_archivo) {
        this.id_archivo = id_archivo;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre.toUpperCase();
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion.toUpperCase();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getFecha_() {
        return fecha_;
    }

    public void setFecha_(String fecha_) {
        this.fecha_ = fecha_;
    }

    public String getHora_() {
        return hora_;
    }

    public void setHora_(String hora_) {
        this.hora_ = hora_;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String[] toArray(){
        String[] row = {
                String.valueOf(id),
                String.valueOf(id_archivo),
                String.valueOf(id_cliente),
                String.valueOf(id_cliente)
        };
        return row;
    }

    public static String getTableName() {
        return TABLE_NAME;
    }

    public static ArchivoLog fromArchivo(Archivo archivo){

        final ArchivoLog archivoLog = new ArchivoLog();

        archivoLog.setNombre(archivo.getNombre());
        archivoLog.setDescripcion(archivo.getDescripcion());
        archivoLog.setFecha(archivo.getFecha());
        archivoLog.setFecha_(Functions.getFecha());
        archivoLog.setHora_(Functions.getHora());
        archivoLog.setId_archivo(archivo.getId_archivo());
        archivoLog.setId_cliente(archivo.getId_cliente());
        archivoLog.setUrl(archivo.getUrl());

        return archivoLog;
    }

    @NonNull
    @Override
    public String toString() {

/*        private int id_archivo;
        private int id_cliente;
        private String fecha;
        private String nombre;
        private String descripcion;
        private String url;*/

        return String.format("ArchivoLog [id=]");
    }
}
