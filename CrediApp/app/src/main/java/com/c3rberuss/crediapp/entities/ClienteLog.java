package com.c3rberuss.crediapp.entities;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = ClienteLog.TABLE_NAME)
public class ClienteLog implements AppVersion {

    @Ignore
    public static final String TABLE_NAME = "cliente_log";

    @PrimaryKey(autoGenerate = true)
    private int id;

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
    private int id_usuario;
    private String fecha_nacimiento;
    private String profesion;
    private String negocio;
    private String direccion_negocio;
    private String actividad_negocio;
    private boolean revisado;


    @ColumnInfo(name = "fecha_log")
    private String fecha;
    @ColumnInfo(name = "hora_log")
    private String hora;

    public String app_version = BuildConfig.VERSION_NAME;

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

    public static String getTableName() {
        return TABLE_NAME;
    }

    public String getApp_version() {
        return app_version;
    }

    public static ClienteLog fromCliente(Cliente cliente){

        final ClienteLog clienteLog = new ClienteLog();

        clienteLog.setNombre(cliente.getNombre());
        clienteLog.setId_cliente(cliente.getId_cliente());
        clienteLog.setDui(cliente.getDui());
        clienteLog.setNit(cliente.getNit());
        clienteLog.setDireccion(cliente.getDireccion());
        clienteLog.setDepartamento(cliente.getDepartamento());
        clienteLog.setMunicipio(cliente.getMunicipio());
        clienteLog.setTelefono(cliente.getTelefono());
        clienteLog.setTelefono2(cliente.getTelefono2());
        clienteLog.setCorreo(cliente.getCorreo());
        clienteLog.setImagen(cliente.getImagen());
        clienteLog.setFecha_registro(cliente.getFecha_registro());
        clienteLog.setFecha_nacimiento(cliente.getFecha_nacimiento());
        clienteLog.setProfesion(cliente.getProfesion());
        clienteLog.setNegocio(cliente.getNegocio());
        clienteLog.setDireccion_negocio(cliente.getDireccion_negocio());
        clienteLog.setActividad_negocio(cliente.getActividad_negocio());
        clienteLog.setRevisado(cliente.isRevisado());
        clienteLog.setFecha(Functions.getFecha());
        clienteLog.setHora(Functions.getHora());
        clienteLog.setId_usuario(cliente.getId_usuario());

        return clienteLog;
    }
}
