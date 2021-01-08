package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.Relation;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;

import java.util.List;

@Entity(tableName = Cliente.TABLE_NAME)
public class Cliente implements AppVersion {

    @Ignore
    public static final String TABLE_NAME = "cliente";

    @PrimaryKey
    private int id_cliente;
    private String nombre;
    private String dui;
    private String nit;
    private String direccion;
    private int departamento;
    private int municipio;
    private String telefono;
    private String telefono2;
    private String correo;
    private String imagen;
    private String fecha_registro;
    private String fecha_nacimiento;
    private String profesion;
    private boolean sincronizado = true;
    private boolean revisado;
    private int id_usuario;

    private String negocio;
    private String direccion_negocio;
    private String actividad_negocio;

    private boolean vetado;

    public String app_version = BuildConfig.VERSION_NAME;

    @Ignore
    @Relation(entity = Referencia.class, parentColumn = "id_cliente", entityColumn = "id_cliente")
    private List<Referencia> referencias;

    @Ignore
    @Relation(entity = Archivo.class, parentColumn = "id_cliente", entityColumn = "id_cliente")
    private List<Archivo> archivos;

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

    public String getDui() {
        return dui;
    }

    public void setDui(String dui) {
        this.dui = dui;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getDireccion() {
        return direccion.toUpperCase();
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getDepartamento() {
        return departamento;
    }

    public void setDepartamento(int departamento) {
        this.departamento = departamento;
    }

    public int getMunicipio() {
        return municipio;
    }

    public void setMunicipio(int municipio) {
        this.municipio = municipio;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTelefono2() {
        return telefono2;
    }

    public void setTelefono2(String telefono2) {
        this.telefono2 = telefono2;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public List<Referencia> getReferencias() {
        return referencias;
    }

    public void setReferencias(List<Referencia> referencias) {
        this.referencias = referencias;
    }

    public List<Archivo> getArchivos() {
        return archivos;
    }

    public void setArchivos(List<Archivo> archivos) {
        this.archivos = archivos;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getProfesion() {
        return profesion;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion.toUpperCase();
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public boolean isRevisado() {
        return revisado;
    }

    public void setRevisado(boolean revisado) {
        this.revisado = revisado;
    }

    public String getNegocio() {
        return negocio;
    }

    public void setNegocio(String negocio) {
        this.negocio = negocio.toUpperCase();
    }

    public String getDireccion_negocio() {
        return direccion_negocio;
    }

    public void setDireccion_negocio(String direccion_negocio) {
        this.direccion_negocio = direccion_negocio.toUpperCase();
    }

    public String getActividad_negocio() {
        return actividad_negocio;
    }

    public void setActividad_negocio(String actividad_negocio) {
        this.actividad_negocio = actividad_negocio.toUpperCase();
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getApp_version() {
        return app_version;
    }

    public boolean isVetado() {
        return vetado;
    }

    public void setVetado(boolean vetado) {
        this.vetado = vetado;
    }
}
