package com.c3rberuss.crediapp.entities;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.google.gson.annotations.SerializedName;

import java.util.List;

@Entity(tableName = SolicitudCredito.TABLE_NAME)
public class SolicitudCredito implements AppVersion {

    @Ignore public static  final String TABLE_NAME = "solicitud";

    @PrimaryKey(autoGenerate = true)
    private int id_solicitud;
    @SerializedName("id_cliente")
    private int id_cliente;
    private String fecha;
    private String hora;
    private float monto;
    private float cuotas;
    private float cuota;
    private int frecuencia;
    private float porcentaje;
    @SerializedName("final")
    private float final_;
    private float abono;
    private float saldo;
    private int plan;
    private int autoriza;
    private boolean entregado;
    private String ultimo_pago;
    private boolean procesada;
    private int estado;
    private boolean divcontrato;
    private int id_vendedor;
    private float contrato;
    private String destino;
    private boolean sincronizada = true;
    private boolean tiene_fiador = false;

    private int refinanciamiento = 0;
    private int id_refinanciado = 0;

    private double mora = 0.0;
    private int dias_mora = 0;

    public String app_version = BuildConfig.VERSION_NAME;

    @Ignore
    private List<SolicitudDetalle> detalles;

    @Ignore
    private Fiador fiador;

    @Ignore
    private List<Garantia> garantias;

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

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public float getMonto() {
        return monto;
    }

    public void setMonto(float monto) {
        this.monto = monto;
    }

    public float getCuotas() {
        return cuotas;
    }

    public void setCuotas(float cuotas) {
        this.cuotas = cuotas;
    }

    public float getCuota() {
        return cuota;
    }

    public void setCuota(float cuota) {
        this.cuota = cuota;
    }

    public int getFrecuencia() {
        return frecuencia;
    }

    public void setFrecuencia(int frecuencia) {
        this.frecuencia = frecuencia;
    }

    public float getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(float porcentaje) {
        this.porcentaje = porcentaje;
    }

    public float getFinal_() {
        return final_;
    }

    public void setFinal_(float final_) {
        this.final_ = final_;
    }

    public float getAbono() {
        return abono;
    }

    public void setAbono(float abono) {
        this.abono = abono;
    }

    public float getSaldo() {
        return saldo;
    }

    public void setSaldo(float saldo) {
        this.saldo = saldo;
    }

    public int getPlan() {
        return plan;
    }

    public void setPlan(int plan) {
        this.plan = plan;
    }

    public int getAutoriza() {
        return autoriza;
    }

    public void setAutoriza(int autoriza) {
        this.autoriza = autoriza;
    }

    public boolean isEntregado() {
        return entregado;
    }

    public void setEntregado(boolean entregado) {
        this.entregado = entregado;
    }

    public String getUltimo_pago() {
        return ultimo_pago;
    }

    public void setUltimo_pago(String ultimo_pago) {
        this.ultimo_pago = ultimo_pago;
    }

    public boolean isProcesada() {
        return procesada;
    }

    public void setProcesada(boolean procesada) {
        this.procesada = procesada;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public boolean isDivcontrato() {
        return divcontrato;
    }

    public void setDivcontrato(boolean divcontrato) {
        this.divcontrato = divcontrato;
    }

    public int getId_vendedor() {
        return id_vendedor;
    }

    public void setId_vendedor(int id_vendedor) {
        this.id_vendedor = id_vendedor;
    }

    public float getContrato() {
        return contrato;
    }

    public void setContrato(float contrato) {
        this.contrato = contrato;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino != null ? destino.toUpperCase() : destino;
    }

    public List<SolicitudDetalle> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<SolicitudDetalle> detalles) {
        this.detalles = detalles;
    }

    public Fiador getFiador() {
        return fiador;
    }

    public void setFiador(Fiador fiador) {
        this.fiador = fiador;
    }

    public List<Garantia> getGarantias() {
        return garantias;
    }

    public void setGarantias(List<Garantia> garantias) {
        this.garantias = garantias;
    }


    public boolean isSincronizada() {
        return sincronizada;
    }

    public void setSincronizada(boolean sincronizada) {
        this.sincronizada = sincronizada;
    }

    public int getId_solicitud() {
        return id_solicitud;
    }

    public void setId_solicitud(int id_solicitud) {
        this.id_solicitud = id_solicitud;
    }

    public boolean isTiene_fiador() {
        return tiene_fiador;
    }

    public void setTiene_fiador(boolean tiene_fiador) {
        this.tiene_fiador = tiene_fiador;
    }

    public int getRefinanciamiento() {
        return refinanciamiento;
    }

    public void setRefinanciamiento(int refinanciamiento) {
        this.refinanciamiento = refinanciamiento;
    }

    public int getId_refinanciado() {
        return id_refinanciado;
    }

    public void setId_refinanciado(int id_refinanciado) {
        this.id_refinanciado = id_refinanciado;
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

    public String getApp_version() {
        return app_version;
    }
}
