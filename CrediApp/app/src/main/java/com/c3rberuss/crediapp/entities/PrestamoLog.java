package com.c3rberuss.crediapp.entities;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import com.c3rberuss.crediapp.BuildConfig;
import com.c3rberuss.crediapp.utils.AppVersion;
import com.c3rberuss.crediapp.utils.Functions;

@Entity(tableName = PrestamoLog.TABLE_NAME)
public class PrestamoLog implements AppVersion {

    public static final String TABLE_NAME = "prestamo_log";

    /*

    SELECT `id_prestamo`, `id_cliente`, `fecha`, `hora`, `monto`, `cuotas`, `cuota`, `frecuencia`, `porcentaje`,
     `final`, `abono`, `saldo`, `plan`, `autoriza`, `entregado`, `ultimo_pago`, `id_vendedor`, `estado` FROM `prestamo` WHERE 1

    SELECT `id_detalle`, `id_prestamo`, `ncuota`, `correlativo`, `monto`, `saldo`, `pagado`, `fecha_pago`, `hora_pago`,
     `mora`, `fecha_vence`, `apertura`, `cajero`, `turno`, `referencia` FROM `prestamo_detalle` WHERE 1
    */

    @PrimaryKey(autoGenerate = true)
    private int id;

    @ColumnInfo
    @NonNull
    private int id_prestamo;
    @ColumnInfo
    private int id_cliente;
    @ColumnInfo
    private String fecha;
    @ColumnInfo
    private String hora;
    @ColumnInfo
    private double monto;
    @ColumnInfo
    private int cuotas;
    @ColumnInfo
    private double cuota;
    @ColumnInfo
    private int frecuencia;
    private double porcentaje;
    @ColumnInfo(name = "final")
    private double finaal;
    @ColumnInfo
    private double abono;
    @ColumnInfo
    private double saldo;
    @ColumnInfo
    private int id_cobrador;
    @ColumnInfo(name = "plan")
    private int plaan;
    @ColumnInfo
    private String ultimo_pago;


    @ColumnInfo(name = "fecha_log")
    private String fecha_;
    @ColumnInfo(name = "hora_log")
    private String hora_;

    @Ignore
    private int numero;
    @ColumnInfo
    private String nombre;
    @ColumnInfo
    private boolean sincronizado = true;
    private boolean abonado = false;

    private double mora = 0.0;
    private int dias_mora = 0;

    public String app_version = BuildConfig.VERSION_NAME;

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

    public boolean isSincronizado() {
        return sincronizado;
    }

    public void setSincronizado(boolean sincronizado) {
        this.sincronizado = sincronizado;
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

    public double getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(double porcentaje) {
        this.porcentaje = porcentaje;
    }

    public static String getTableName() {
        return TABLE_NAME;
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

    public boolean isAbonado() {
        return abonado;
    }

    public void setAbonado(boolean abonado) {
        this.abonado = abonado;
    }

    public static PrestamoLog fromPrestamo(Prestamo prestamo){
        final PrestamoLog prestamoLog = new PrestamoLog();

        prestamoLog.setId_prestamo(prestamo.getId_prestamo());
        prestamoLog.setId_cliente(prestamo.getId_cliente());
        prestamoLog.setId_cobrador(prestamo.getId_cobrador());
        prestamoLog.setFrecuencia(prestamo.getFrecuencia());
        prestamoLog.setCuotas(prestamo.getCuotas());
        prestamoLog.setMonto(prestamo.getMonto());
        prestamoLog.setAbono(prestamo.getAbono());
        prestamoLog.setSaldo(prestamo.getSaldo());
        prestamoLog.setFinaal(prestamo.getFinaal());
        prestamoLog.setCuota(prestamo.getCuota());
        prestamoLog.setFecha(prestamo.getFecha());
        prestamoLog.setHora(prestamo.getHora());
        prestamoLog.setPlaan(prestamo.getPlaan());

        prestamoLog.setAbonado(prestamo.isAbonado());

        prestamoLog.setFecha_(Functions.getFecha());
        prestamoLog.setHora_(Functions.getHora());

        return prestamoLog;
    }
}
