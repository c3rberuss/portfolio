package com.c3rberuss.crediapp.entities;

import androidx.room.ColumnInfo;

public class NumCuota {

    private int id_detalle;
    private int id_prestamo;
    private int correlativo;
    private int ncuota, pagado;
    private double monto, mora;
    private double saldo;
    @ColumnInfo
    private String fecha_pago;
    @ColumnInfo
    private String fecha_vence;
    @ColumnInfo
    private String hora_pago;

    /*
    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`,
     `fecha_pago`, `hora_pago`, `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia`
     FROM `prestamo_detalle` WHERE 1
    */

    public int getId_detalle() {
        return id_detalle;
    }
    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
    }
    public int getId_Prestamo() {
        return id_prestamo;
    }
    public void setId_Prestamo(int id_prestamo) {
        this.id_prestamo = id_prestamo;
    }
    public int getNcuota() {
        return ncuota;
    }
    public void setNcuota(int ncuota) {
        this.ncuota = ncuota;
    }

    public int getCorrelativo() {
        return correlativo;
    }
    public  void setCorrelativo(int correlativo) {
        this.correlativo=correlativo;
    }

    public double getMonto() {
        return monto;
    }

    public  void setMonto(double monto) {
        this.monto=monto;
    }

    public double getSaldo() {
        return saldo;
    }

    public  void setSaldo(double saldo) {
        this.saldo=saldo;
    }
    public double getMora() {
        return mora;
    }

    public  void setMora(double mora) {
        this.mora=mora;
    }

    public int getPagado() {
        return pagado;
    }
    public void setPagado(int pagado) {
        this.pagado = pagado;
    }
    public String getFecha_pago(){
        return fecha_pago;
    }
    public  void setFecha_pago(String fecha_pago){
        this.fecha_pago=fecha_pago;
    }

    public String getFecha_vence(){
        return fecha_vence;
    }
    public  void setFecha_vence(String fecha_vence){
        this.fecha_vence=fecha_vence;
    }

    public String getHora_pago(){
        return hora_pago;
    }
    public  void setHora_pago(String hora_pago){
        this.hora_pago=hora_pago;
    }

}
