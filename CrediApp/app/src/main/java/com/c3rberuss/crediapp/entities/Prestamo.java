package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.Relation;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.google.gson.annotations.SerializedName;

import java.util.List;

@Entity(tableName = Prestamo.TABLE_NAME)
public class Prestamo implements AppVersion {

    public static final String TABLE_NAME = "prestamo";

    @PrimaryKey
    @ColumnInfo
    @NonNull
    private int id_prestamo;
    @ColumnInfo
    private int id_cliente;
    @ColumnInfo
    private int id_cobrador;
    @ColumnInfo
    private int frecuencia;
    @ColumnInfo
    private int cuotas;
    @ColumnInfo
    private double monto;
    @ColumnInfo
    private double abono;
    @ColumnInfo
    private double saldo;
    @ColumnInfo
    private double finaal;
    @ColumnInfo
    private double cuota;
    @ColumnInfo
    private String fecha;
    @ColumnInfo
    private String hora;

    @Ignore
    private int numero;
    @ColumnInfo
    private String nombre;
    @ColumnInfo
    private String ultimo_pago;
    @ColumnInfo
    private int plaan;

    @ColumnInfo
    private boolean sincronizado = true;

    private boolean abonado = false;

    private double porcentaje;

    private double mora = 0.0;
    private int dias_mora = 0;

    private boolean atrasado = false;
    private String proxima_mora = "0000-00-00";

    private int estado;

    public String app_version = BuildConfig.VERSION_NAME;

    @SerializedName("detalle")
    @Ignore
    @Relation(entity = PrestamoDetalle.class, parentColumn = "id_prestamo", entityColumn = "id_prestamo")
    private List<PrestamoDetalle> prestamodetalle;

    @Ignore
    private List<Abono> abonos;

    @Ignore
    private double moraTotal = 0.0;

    @Ignore
    PagosMora pagoMora;

    public int getId_prestamo() {
        return id_prestamo;
    }
    public void setId_prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }

    public int getId_cliente() {
        return id_cliente;
    }
    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_cobrador() {
        return id_cobrador;
    }
    public void setId_cobrador(int id_cobrador) {
        this.id_cobrador = id_cobrador;
    }

    public int getCuotas() {
        return cuotas;
    }
    public void setCuotas(int cuotas) { this.cuotas = cuotas;  }

    public double getCuota() {
        return cuota;
    }
    public void setCuota(double cuota) { this.cuota = cuota; }

    public int getFrecuencia() {
        return frecuencia;
    }
    public void setFrecuencia(int frecuencia) {
        this.frecuencia = frecuencia;
    }

    public double getMonto() {
        return monto;
    }
    public void setMonto(double  monto) { this.monto = monto; }

    public double getSaldo() {
        return saldo;
    }
    public void setSaldo(double  saldo) { this.saldo =saldo; }

    public double getAbono() {
        return abono;
    }
    public void setAbono(double  abono) { this.abono = abono; }

    public double getFinaal() {
        return finaal;
    }
    public void setFinaal(double finaal) { this.finaal =finaal; }

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


    public int getNumero() {
        return numero;
    }
    public void setNumero(int  numero) {
        this.numero = numero;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUltimo_pago() {
        return ultimo_pago;
    }
    public void setUltimo_pago(String ultimo_pago) {
        this.ultimo_pago = ultimo_pago;
    }

    public int getPlaan() {
        return plaan;
    }
    public void setPlaan(int  plaan) {
        this.plaan = plaan;
    }

    public List<PrestamoDetalle> getPrestamodetalle() { return  prestamodetalle; }
    public void  setPrestamoDetalle(List<PrestamoDetalle> prestamodetalle) {
        this.prestamodetalle=prestamodetalle;
    }

    public double getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(double porcentaje) {
        this.porcentaje = porcentaje;
    }

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
    }

    public double getMoraTotal() {
        return moraTotal;
    }

    public void setMoraTotal(double moraTotal) {
        this.moraTotal = moraTotal;
    }

    public double getMora() {
        return mora;
    }

    public void setMora(double mora) {
        this.mora = mora;
    }

    public int getDias_mora() {
        return dias_mora;
    }

    public void setDias_mora(int dias_mora) {
        this.dias_mora = dias_mora;
    }

    public boolean isAbonado() {
        return abonado;
    }

    public void setAbonado(boolean abonado) {
        this.abonado = abonado;
    }

    public String getApp_version() {
        return app_version;
    }

    public List<Abono> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<Abono> abonos) {
        this.abonos = abonos;
    }

    public int getEstado(){
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public boolean isAtrasado() {
        return atrasado;
    }

    public void setAtrasado(boolean atrasado) {
        this.atrasado = atrasado;
    }

    public String getProxima_mora() {
        return proxima_mora;
    }

    public void setProxima_mora(String proxima_mora) {
        this.proxima_mora = proxima_mora;
    }

    public PagosMora getPagoMora() {
        return pagoMora;
    }

    public void setPagoMora(PagosMora pagoMora) {
        this.pagoMora = pagoMora;
    }
}
