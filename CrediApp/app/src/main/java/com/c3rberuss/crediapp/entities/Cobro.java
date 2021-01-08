package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(tableName = "cobro")
public class Cobro {
    /*

    SELECT `id_prestamo`, `id_cliente`, `fecha`, `hora`, `monto`, `cuotas`, `cuota`, `frecuencia`, `porcentaje`,
     `final`, `abono`, `saldo`, `plan`, `autoriza`, `entregado`, `ultimo_pago`, `id_vendedor`, `estado` FROM `prestamo` WHERE 1

    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`, `fecha_pago`, `hora_pago`,
     `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia` FROM `prestamo_detalle` WHERE 1
    */
    @ColumnInfo
    @PrimaryKey
    @NonNull
    private int id_cobro;
    @ColumnInfo
    private int id_cliente;
    @ColumnInfo
    private int id_cobrador;
    /*
    @ColumnInfo
    private int numerocuota;
        @ColumnInfo
        private  double montocobrar;
        @ColumnInfo
        private double montoabonado;
        */
    @ColumnInfo
    private String fecha;
    @ColumnInfo
    private String hora;

    @Ignore
    private int numero;
    @Ignore
    private String nombre;

    public int getId_cobro() {
        return id_cobro;
    }
    public void setId_cobro(int id_cobro) {
        this.id_cobro = id_cobro;
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

    /*
    public int getNumeroCuota() {
        return numerocuota;
    }
    public void setNumeroCuota(int numerocuota) {
        this.numerocuota = numerocuota;
    }

    public double getMontoCobrar() {
        return montocobrar;
    }
    public void setMontoCobrar(double montocobrar) {
        this.montocobrar = montocobrar;
    }

    public double getMontoAbonado() {
        return montoabonado;
    }
    public void setMontoAbonado(double montocobrar) {
        this.montoabonado =montoabonado;
    }
       */
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
        this.fecha = nombre;
    }
}
