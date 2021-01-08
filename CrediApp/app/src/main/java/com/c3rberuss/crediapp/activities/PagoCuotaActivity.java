package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.SearchView;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.PrestamoDetalleAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.AbonoDao;
import com.c3rberuss.crediapp.database.dao.CobroProcesadoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.utils.DialogoAbono;
import com.c3rberuss.crediapp.utils.DialogoEfectivo;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.PrinterCommands;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PagoCuotaActivity extends AppCompatActivity {
    RecyclerView recycler;
    PrestamoDetalleAdapter adapter;
    List<PrestamoDetalle> clientes = new ArrayList<>();
    SearchView searchView;
    int id_prestamo = 0, ncuotas = 0;
    String nombreCliente = "";
    TextView lblNombreCliente, txtTotalFinal, txtTotalCuotas, txtTotalMora;
    ImageButton btnFinPagar, btnPrintPago;

    BluetoothAdapter bluetoothAdapter;
    BluetoothSocket socket;
    BluetoothDevice bluetoothDevice;
    OutputStream outputStream;
    InputStream inputStream;
    Thread workerThread;
    byte[] readBuffer;
    int readBufferPosition;
    volatile boolean stopWorker;
    String value = "";
    String proceso = "CALC";
    int id_cobrador = 0;
    DialogoEfectivo dialog;

    @BindView(R.id.lblSaldo)
    TextView lblSaldo;
    @BindView(R.id.saldo_cuota_row)
    TableRow saldoCuotaRow;
    @BindView(R.id.btnAbonar)
    Button btnAbonar;
    @BindView(R.id.lblAbono)
    TextView lblAbono;
    @BindView(R.id.cardView4)
    CardView cardView4;

    //private Plan plan;

    private Prestamo prestamo;
    String referencia = "";
    double efectivoRecibido = 0.0;

    DialogoAbono dialogoAbono;
    PrestamoDetalle cuotaAbonar;
    Abono abono;
    CobroProcesado cobroProcesado;
    double dineroAbonado = 0.0;

    AbonoDao abonoDao;
    PrestamoDao prestamoDao;
    PrestamoDetalleDao prestamoDetalleDao;
    CobroProcesadoDao cobroProcesadoDao;

    double saldoPrestamo = 0.0;
    double montoPrestamo = 0.0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pago_cuota);
        ButterKnife.bind(this);

        setTitle("Pago de Cuotas");
        abonoDao = AppDatabase.getInstance(PagoCuotaActivity.this).getAbonoDao();
        prestamoDao = AppDatabase.getInstance(PagoCuotaActivity.this).prestamoDao();
        prestamoDetalleDao = AppDatabase.getInstance(PagoCuotaActivity.this).prestamoDetalleDao();
        cobroProcesadoDao = AppDatabase.getInstance(PagoCuotaActivity.this).getCobrosProcesados();

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        recycler = findViewById(R.id.lista_clientes);
        lblNombreCliente = (TextView) findViewById(R.id.lblNombCliente);
        txtTotalFinal = (TextView) findViewById(R.id.txtTotalFinal);
        txtTotalCuotas = (TextView) findViewById(R.id.txtTotalCuotas);
        txtTotalMora = (TextView) findViewById(R.id.txtTotalMora);
        btnFinPagar = (ImageButton) findViewById(R.id.btnFinPagar);
        btnPrintPago = (ImageButton) findViewById(R.id.btnPrintPago);
        btnPrintPago.setEnabled(false);
        Intent iin = getIntent();
        Bundle b = iin.getExtras();

        id_cobrador = AppDatabase.getInstance(getApplicationContext()).getUsuarioDao().getId();


        if (b != null) {
            id_prestamo = b.getInt("id_prestamo");
            nombreCliente = b.getString("nombre");
            ncuotas = b.getInt("ncuotas");
            lblNombreCliente.setText(nombreCliente);
            //plan = AppDatabase.getInstance(this).getPlanesDao().get(AppDatabase.getInstance(this).prestamoDao().getIdPlan(id_prestamo));
            prestamo = AppDatabase.getInstance(this).prestamoDao().getPrestamo_(id_prestamo);
            // Toast.makeText(getApplicationContext(), "Prestamo Seleccionado---> "+id_prestamo, Toast.LENGTH_LONG).show();
        }
        getTasks(id_prestamo, proceso);

        btnFinPagar.setOnClickListener(v -> {
            //Toast.makeText(getApplicationContext(), " Prestamo Seleccionado:" + id_prestamo, Toast.LENGTH_LONG).show();
            // UpdatePrestamoDet(id_prestamo);

            //cambioDialog();
            dialog = new DialogoEfectivo(this, Double.valueOf(txtTotalFinal.getText().toString()), (efectivo) -> {
                efectivoRecibido = efectivo;
                proceso = "UPD";
                getTasks(id_prestamo, proceso);
                setResult(RESULT_OK);
            });

            dialog.show();
        });
        btnPrintPago.setOnClickListener(v -> {
            // Toast.makeText(getApplicationContext(), " Prestamo Seleccionado:"+id_prestamo, Toast.LENGTH_LONG).show();
            printPagocuota(id_prestamo);
        });
    }


    private void getTasks(int id_prestamo, String proceso) {

        final Dialog process_dialog = Functions.progressDialog(this, "Cargando datos...");

        class GetTasks extends AsyncTask<Void, Void, List<PrestamoDetalle>> {
            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                process_dialog.show();
            }

            //recycler de cuotas a pagar
            @Override
            protected List<PrestamoDetalle> doInBackground(Void... voids) {

                List<PrestamoDetalle> taskList = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDetalleDao()
                        .getPrestamoDetalleByCuota(id_prestamo, ncuotas);

                for (PrestamoDetalle pd : taskList) {
                    final Mora m = AppDatabase.getInstance(getApplicationContext())
                            .prestamoDao()
                            .getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

                    taskList.set(taskList.indexOf(pd),
                            Functions.tieneMora(pd, m));
                }

                return taskList;
            }

            @Override
            protected void onPostExecute(List<PrestamoDetalle> clientes) {
                super.onPostExecute(clientes);
                adapter = new PrestamoDetalleAdapter(getApplicationContext(), clientes, prestamo, 1);
                recycler.setAdapter(adapter);

                final int n_cuota = clientes.get(clientes.size() - 1).getNcuota() + 1;

                if (n_cuota > prestamo.getCuotas()) {

                    cardView4.setVisibility(View.GONE);

                } else {

                    cuotaAbonar = AppDatabase.getInstance(PagoCuotaActivity.this).prestamoDetalleDao().getCuotaAbonar(n_cuota, id_prestamo);

                    final Mora mora = AppDatabase.getInstance(PagoCuotaActivity.this)
                            .prestamoDao().getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

                    cuotaAbonar = Functions.tieneMora(cuotaAbonar, mora);

                    dialogoAbono = new DialogoAbono(
                            PagoCuotaActivity.this,
                            cuotaAbonar,
                            efectivo -> {

                                double tfinal = Double.valueOf(txtTotalFinal.getText().toString());
                                tfinal -= dineroAbonado;

                                lblSaldo.setText(Functions.round2decimals(cuotaAbonar.getMora() +
                                        cuotaAbonar.getMonto() - efectivo));

                                txtTotalFinal.setText(Functions.round2decimals(tfinal+ efectivo));
                                dineroAbonado = efectivo;

                                lblAbono.setText(Functions.round2decimals(efectivo));

                                abono = new Abono();

                            });

                    btnAbonar.setOnClickListener(v -> dialogoAbono.show());
                }

                process_dialog.dismiss();
            }
        }
        //calculos de total a pagar incluyendo calculo de mora
        class MisCalc extends AsyncTask<Void, Void, Double> {

            double totalfin = 0.0, porcentaje_mora = 0.0, monto = 0.0, mora_actual = 0.0, total_mora = 0.0;
            int dias_mora = 0, dias_vencido = 0, dias_cobro_mora = 0;
            String fecha_vence, fecha_actual = Functions.getFecha();
            double totalAbonoCuotas = 0;
            String fecha_pago = Functions.getFecha();
            double totalmonto = 0.0;
            int id_plan = 0;

            @Override
            protected Double doInBackground(Void... voids) {

                //COMENTADO POR MODIFICACIONES
               /* totalmonto = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDetalleDao().getMontoPrestamoDetalleLimit(id_prestamo, ncuotas);*/


                id_plan = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getPlaan(id_prestamo);

                /*List<Plan> listDatosMora = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao()
                        .getListByIdPlan(id_plan);

                for (int i = 0; i < listDatosMora.size(); i++) {
                    Plan miPlan = listDatosMora.get(i);
                    dias_mora = miPlan.getDias_mora();
                    porcentaje_mora = miPlan.getMora();
                }*/

                //Mora nuevo
                final Mora m_ = AppDatabase.getInstance(getApplicationContext())
                        .prestamoDao()
                        .getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

                dias_mora = m_.getDias_mora();
                porcentaje_mora = m_.getMora();

                //FIN

                List<PrestamoDetalle> listCuotasPrestamo = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDetalleDao()
                        .getPrestamoDetalleByCuota(id_prestamo, ncuotas);


                referencia = Functions.uniqid("", false);

                for (int j = 0; j < listCuotasPrestamo.size(); j++) {
                    PrestamoDetalle miPrestamoDet = listCuotasPrestamo.get(j);
                    monto = miPrestamoDet.getMonto();
                    fecha_vence = miPrestamoDet.getFecha_vence().toString();

                    dias_vencido = Functions.diasDiferenciaFechas(fecha_vence, fecha_actual);

                    final double[] mora_data = Functions.getMora(miPrestamoDet, dias_mora, porcentaje_mora);

                    dias_cobro_mora = (int) mora_data[1];

                    if(miPrestamoDet.getAbono() > monto){
                        totalAbonoCuotas += 0;
                        totalmonto += 0;
                        mora_actual = mora_data[0]-(miPrestamoDet.getAbono()-monto);
                    }else{
                        totalAbonoCuotas += (monto - miPrestamoDet.getAbono());
                        totalmonto += (monto - miPrestamoDet.getAbono());
                        mora_actual = mora_data[0];
                    }

                    //total_mora += mora_data[0];
                    total_mora += mora_actual;

                    //double m = Functions.getMora(miPrestamoDet, dias_mora, porcentaje_mora);
                    //System.out.println(m);

                    //Log.e("MORA", String.valueOf(Functions.getMora(miPrestamoDet, dias_mora, porcentaje_mora)));

                    if (proceso == "UPD") {
                        int id_detalle = miPrestamoDet.getId_detalle();
                        String hora_pago = Functions.getHora();

                        if(abono != null && dineroAbonado >= 0.01){

                            System.out.println("ABONO");

                            miPrestamoDet.setPagado(1);
                            miPrestamoDet.setEfectivo(efectivoRecibido);
                            miPrestamoDet.setFecha_pago(fecha_pago);
                            miPrestamoDet.setHora_pago(hora_pago);
                            miPrestamoDet.setMora(mora_actual);
                            miPrestamoDet.setId_cobrador(id_cobrador);
                            miPrestamoDet.setReferencia(referencia);
                            miPrestamoDet.setAbonado(true);
                            miPrestamoDet.setSincronizado(false);

                            prestamoDetalleDao.updatePrestamoDetalle(miPrestamoDet);

                        }else{
                            AppDatabase
                                    .getInstance(getApplicationContext())
                                    .prestamoDetalleDao()
                                    .updateByIdPrestamoDetalle(id_detalle, fecha_pago,
                                            hora_pago, referencia, mora_actual, id_cobrador, efectivoRecibido);
                        }

                        final CobroProcesado cobro = new CobroProcesado(1, prestamo.getId_prestamo(), id_cobrador);

                        if(miPrestamoDet.getAbono() > monto){
                            cobro.setMonto(0);
                            cobro.setMora(mora_actual-(miPrestamoDet.getAbono()-miPrestamoDet.getMonto()));
                        }else{
                            cobro.setMonto(miPrestamoDet.getMonto()-miPrestamoDet.getAbono());
                            cobro.setMora(mora_actual);
                        }

                        cobroProcesadoDao.insert(cobro);
                    }
                    Log.d("MORA-->:", " dias cobro: " + dias_cobro_mora + " mora cuota:" + mora_actual);

                }
                //String totalmontox = Functions.round2(totalAbonoCuotas);
                //String totalmorax = Functions.round2(total_mora);
                totalfin = Double.parseDouble(Functions.round2decimals(total_mora)) + Double.parseDouble(Functions.round2decimals(totalmonto));

                if (proceso == "UPD") {
                    //fin calculo mora
                    //Actualizar Saldo del prestamo
                    //Agregar para actualizar id_usuario que realiza cobro ojo !!!!!

                    //TODO: actualizar cambios

                    if(abono != null && dineroAbonado >= 0.01){
                        System.out.println("ABONO");

                        cuotaAbonar.setAbono(cuotaAbonar.getAbono() + dineroAbonado);
                        cuotaAbonar.setMonto_abono(dineroAbonado);
                        cuotaAbonar.setAbonado(true);
                        cuotaAbonar.setSincronizado(false);

                        cuotaAbonar.setPagado(0);
                        cuotaAbonar.setId_cobrador(id_cobrador);

/*                        if ((cuotaAbonar.getMonto() + cuotaAbonar.getMora()-cuotaAbonar.getAbono()) <= 0.05) {
                            cuotaAbonar.setEfectivo(dineroAbonado);
                            cuotaAbonar.setReferencia(Functions.uniqid("", false));
                            cuotaAbonar.setFecha_pago(Functions.getFecha());
                            cuotaAbonar.setHora_pago(Functions.getHora());
                        }*/

                        cobroProcesado =
                                new CobroProcesado(1, prestamo.getId_prestamo(), AppDatabase.getInstance(PagoCuotaActivity.this).getUsuarioDao().getId());

                        cobroProcesado.setMonto(dineroAbonado);

                        System.out.println("Se Actualizó");

                        abono.setId_detalle(cuotaAbonar.getId_detalle());
                        abono.setValor(dineroAbonado);
                        abono.setSincronizado(false);

                        final double tsaldo = prestamo.getSaldo() - (totalAbonoCuotas + dineroAbonado);
                        final double tabono = prestamo.getAbono() + totalAbonoCuotas + dineroAbonado;

                        prestamo.setSaldo(tsaldo);
                        prestamo.setAbono(tabono);

                        prestamo.setUltimo_pago(Functions.getFecha());

                        prestamo.setAbonado(true);
                        prestamo.setSincronizado(false);

                        abonoDao.insert(abono);
                        prestamoDao.updatePrestamo(prestamo);
                        prestamoDetalleDao.updatePrestamoDetalle(cuotaAbonar);
                        cobroProcesadoDao.insert(cobroProcesado);

                    }else{
                        AppDatabase
                                .getInstance(getApplicationContext())
                                .prestamoDao()
                                .updateByIdPrestamo(id_prestamo, totalAbonoCuotas, fecha_pago, id_cobrador);
                    }
                }

                return totalfin;
            }


            protected void onPostExecute(Double result) {
                super.onPostExecute(result);
                Log.d("Downloaded ", "" + result);
                txtTotalFinal.setText(Functions.round2decimals(result));
                if (proceso == "CALC") {
                   /* txtTotalCuotas.setText(totalmontox);
                    txtTotalMora.setText(totalmorax);
                    txtTotalFinal.setText("" + totalfin);*/

                    updateValues(totalAbonoCuotas, total_mora, totalmonto);

                   /* txtTotalCuotas.setText(Functions.round2decimals(totalAbonoCuotas));
                    txtTotalMora.setText(Functions.round2decimals(total_mora));
                    txtTotalFinal.setText(Functions.round2decimals(total_mora + totalmonto));*/


                }
            }
        }
        //  if (proceso=="CALC") {
        GetTasks gt = new GetTasks();
        gt.execute();
        //    }
        MisCalc mc = new MisCalc();
        mc.execute();
        if (proceso == "UPD") {
            btnAbonar.setEnabled(false);
            btnFinPagar.setEnabled(false);
            btnPrintPago.setEnabled(true);
            Dialogs.printer(PagoCuotaActivity.this,
                    "Exito",
                    "Los pagos fueron realizados exitosamente",
                    v -> {
                        printPagocuota(id_prestamo);
                        v.dismiss();
                    }, v -> {
                        v.dismiss();
                        setResult(RESULT_OK);
                    }).show();
        }

    }


    void updateValues(double totalAbonoCuotas, double total_mora, double totalmonto) {
        txtTotalCuotas.setText(Functions.round2decimals(totalAbonoCuotas));

        txtTotalMora.setText(Functions.round2decimals(total_mora));

        txtTotalFinal.setText(Functions.round2decimals(total_mora + totalmonto));
    }


    //mostrar los pagos x cuota y calculos de total a pagar incluyendo calculo de mora
    /*
    private void getTasks(int id_prestamo,String proceso){
        class GetTasks extends AsyncTask<Void, Void, List<PrestamoDetalle>> {
            //recycler de cuotas a pagar
            @Override
            protected List<PrestamoDetalle> doInBackground(Void... voids) {
                List<PrestamoDetalle> taskList = PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDetalleDao()
                        . getPrestamoDetalleByCuota(id_prestamo, ncuotas);
                return taskList;
            }
            @Override
            protected void onPostExecute(List<PrestamoDetalle> clientes) {
                super.onPostExecute(clientes);
                PrestamoDetalleAdapter adapter = new PrestamoDetalleAdapter(getApplicationContext(),clientes);
                recycler.setAdapter(adapter);

            }
        }
        //calculos de total a pagar incluyendo calculo de mora
        class MisCalc extends AsyncTask<Void, Void, Double> {
            @Override
            protected Double  doInBackground(Void... voids ) {
                double totalfin =0.0, porcentaje_mora=0.0,monto=0.0, mora_actual=0.0,total_mora=0.0;
                int dias_mora=0,dias_vencido=0, dias_cobro_mora=0;
                String fecha_vence, fecha_actual;
                fecha_actual=Functions.getFecha();
                double totalmonto = PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDetalleDao().getMontoPrestamoDetalleLimit(id_prestamo, ncuotas);

                int  id_plan = PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDao().getPlaan(id_prestamo);

                List<Plan> listDatosMora=PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDao()
                        .getListByIdPlan(id_plan);
                for (int i=0; i<listDatosMora.size(); i++) {
                    Plan miPlan =listDatosMora.get(i);
                    dias_mora=miPlan.getDias_mora();
                    porcentaje_mora=miPlan.getMora();

                }
                List<PrestamoDetalle> listCuotasPrestamo=PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDetalleDao()
                        .getPrestamoDetalleByCuota(id_prestamo, ncuotas);

                for (int j=0; j<listCuotasPrestamo.size(); j++) {
                    PrestamoDetalle miPrestamoDet =listCuotasPrestamo.get(j);
                    monto=miPrestamoDet.getMonto();
                    fecha_vence=miPrestamoDet.getFecha_vence();
                    dias_vencido=Functions.diasDiferenciaFechas(fecha_vence, fecha_actual);
                    dias_cobro_mora=dias_vencido-dias_mora;
                    if(dias_cobro_mora>0){
                        mora_actual=monto*(porcentaje_mora/100)*(dias_vencido-dias_mora);

                    }
                    else{
                        mora_actual=0;
                    }
                    Log.d("MORA-->:"," dias cobro: "+dias_cobro_mora+ " mora cuota:"+mora_actual);
                    total_mora+=mora_actual;
                }
                String totalmontox=Functions.round2(totalmonto);
                String totalmorax=Functions.round2(total_mora);
                totalfin = Double.parseDouble(Functions.round2(total_mora))+Double.parseDouble(Functions.round2(totalmonto));
                txtTotalCuotas.setText(totalmontox);
                txtTotalMora.setText(totalmorax);
                txtTotalFinal.setText("" + totalfin);

                return totalfin;
            }


            protected void onPostExecute(Double result) {
                super.onPostExecute(result);
                Log.d("Downloaded ","" + result);
                txtTotalFinal.setText("" + result);
            }
        }
        GetTasks gt = new GetTasks();
        gt.execute();

        MisCalc mc= new MisCalc();
        mc.execute();
    }
    */
    //actualizar prestamo y detalle de prestamo
    /*
    private void UpdatePrestamoDet(int id_prestamo) {
        class UpdatePrestamo extends AsyncTask<Void, Void, List<PrestamoDetalle>> {

            @Override
            protected List<PrestamoDetalle> doInBackground(Void... voids) {
                double totalfin =0.0, porcentaje_mora=0.0,monto=0.0, mora_actual=0.0,total_mora=0.0;
                int dias_mora=0,dias_vencido=0, tiene_mora=0;
                String fecha_vence, fecha_actual;
                fecha_actual=Functions.getFecha();

                List<PrestamoDetalle> listCuotasPrestamo=PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDetalleDao()
                        .getPrestamoDetalleByCuota(id_prestamo, ncuotas);

                double totalAbonoCuotas=0;
                String fecha_pago = Functions.getFecha();
                String hora_pago= Functions.getHora();
                String referencia="";

                //inicio calculo mora
                int  id_plan = PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDao().getPlaan(id_prestamo);

                List<Plan> listDatosMora=PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDao()
                        .getListByIdPlan(id_plan);
                for (int i=0; i<listDatosMora.size(); i++) {
                    Plan miPlan =listDatosMora.get(i);
                    dias_mora=miPlan.getDias_mora();
                    porcentaje_mora=miPlan.getMora();
                }

                for (int j=0; j<listCuotasPrestamo.size(); j++) {
                    PrestamoDetalle miPrestamoDet =listCuotasPrestamo.get(j);
                    int id_detalle=miPrestamoDet.getId_detalle();
                    monto=miPrestamoDet.getMonto();
                    referencia=Functions.getHash();
                    fecha_vence=miPrestamoDet.getFecha_vence();
                    dias_vencido=Functions.diasDiferenciaFechas(fecha_vence, fecha_actual);
                    // tiene_mora=dias_vencido-dias_mora;
                    if(dias_vencido>dias_mora){
                        mora_actual=monto*(porcentaje_mora/100)*(dias_vencido-dias_mora);
                    }
                    else{
                        mora_actual=0;
                    }
                    PrestamoDetalleAdm
                            .getInstance(getApplicationContext())
                            .getAppDatabase()
                            .prestamoDetalleDao()
                            .updateByIdPrestamoDetalle(id_detalle, fecha_pago, hora_pago,referencia, mora_actual);

                }

                //fin calculo mora
                //Actualizar Saldo del prestamo
                PrestamoDetalleAdm
                        .getInstance(getApplicationContext())
                        .getAppDatabase()
                        .prestamoDao()
                        .updateByIdPrestamo(id_prestamo,totalAbonoCuotas,fecha_pago);

                return clientes;
            }
            @Override
            protected void onPostExecute(List<PrestamoDetalle> clientes) {
                super.onPostExecute(clientes);

                Toast.makeText(getApplicationContext(), "Prestamo Actualizado:"+id_prestamo, Toast.LENGTH_LONG).show();
            }
        }
        UpdatePrestamo gt = new UpdatePrestamo();
        gt.execute();
        btnFinPagar.setEnabled(false);
        btnPrintPago.setEnabled(true);
    }
*/

    //imprimir recibo de pago de cuotas
    private void printPagocuota(int id_prestamo) {

        Dialog dialog = Functions.progressDialog(this, "Imprimiendo ticket, espere un momento...");

        class PrintPagoCuota extends AsyncTask<Void, Void, List<PrestamoDetalle>> {

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
                dialog.show();
            }

            String fecha_pago = Functions.getFecha();

            @Override
            protected List<PrestamoDetalle> doInBackground(Void... voids) {

                /*List<PrestamoDetalle> clientes = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDetalleDao()
                        .getCuotaPagadaFecha(id_prestamo, fecha_pago);*/

                List<PrestamoDetalle> clientes = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDetalleDao()
                        .getCuotaPagadaReferencia(id_prestamo, referencia);

                List<Prestamo> prestamo = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getByIdPrestamo(id_prestamo);

                String nombre = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getNombreCliente(id_prestamo);

                IntentPrint(clientes, nombre, prestamo);

                return clientes;
            }

            @Override
            protected void onPostExecute(List<PrestamoDetalle> clientes) {
                super.onPostExecute(clientes);
                for (int j = 0; j < clientes.size(); j++) {
                    PrestamoDetalle miPrestamoDet = clientes.get(j);
                    int id_detalle = miPrestamoDet.getId_detalle();
                    // Toast.makeText(getApplicationContext(), "Cuota Prestamo Seleccionado:"+id_detalle, Toast.LENGTH_LONG).show();
                }
                dialog.dismiss();
                setResult(RESULT_OK);
                finish();
            }
        }
        PrintPagoCuota gt = new PrintPagoCuota();
        gt.execute();
    }

    //Impresion de Recibo

    //impresion !!!
    public void IntentPrint(List<PrestamoDetalle> clientes, String nombre, List<Prestamo> prestamo) {
        // Usuario


        String textoEncabRecibo = "", textoEncabRecibo2 = "", value = "";
        String textoRecibo = "";
        double totalsaldoAnterior = 0.0, totalAbonoActual = 0.0, totalAbonoFinal = 0.0, totalSaldoFinal = 0.0, abonadoAnterior = 0.0, saldoAnterior = 0.0, totalMora = 0.0;
        double abonadoActual = 0.0, saldoActual = 0.0;
        String fecha_p = Functions.getFecha();
        String fecha_pago = Functions.fechaDMY(fecha_p);
        String hora_pago = Functions.getHora();
        String nombres = Functions.removerTildes(nombre);
        textoEncabRecibo += "" + "\n";
        textoEncabRecibo += "CREDI - MASTER " + "\n\n";
        textoEncabRecibo += "COMPROBANTE DE ABONO" + "\n\n";
        textoEncabRecibo += "--------------------------------" + "\n";

        textoEncabRecibo2 += "FECHA: " + fecha_pago + "    " + hora_pago + " \n";
        //textoEncabRecibo2 += "HORA: " + hora_pago + " \n";
        textoEncabRecibo2 += "CLIENTE: " + nombres + " \n";
        textoEncabRecibo2 += "COBRADOR: " + AppDatabase.getInstance(this).getUsuarioDao().getNombre().toUpperCase();
        textoEncabRecibo2 += "--------------------------------" + "\n";
        textoEncabRecibo2 += " ABONA CUOTAS" + "\n";

        //imprime monto prestado
        for (int i = 0; i < prestamo.size(); i++) {
            Prestamo miPrestamo = prestamo.get(i);
            int id_prestamo = miPrestamo.getId_prestamo();
            double montoprestado = miPrestamo.getMonto();
            double finaal = miPrestamo.getFinaal();
            abonadoActual = miPrestamo.getAbono();
            saldoActual = miPrestamo.getSaldo();
            //textoEncabRecibo2  =  textoEncabRecibo2  + "MONTO PRESTADO $ "+montoprestado + "\n";
            //textoEncabRecibo2  =  textoEncabRecibo2 + "MONTO FINAL $ "+finaal + "\n";

        }


        String referencias = "";

        for (int j = 0; j < clientes.size(); j++) {
            PrestamoDetalle miPrestamoDet = clientes.get(j);
            int id_detalle = miPrestamoDet.getId_detalle();
            double monto = miPrestamoDet.getMonto();
            double mora = miPrestamoDet.getMora();
            String correlativo = " CUOTA " + miPrestamoDet.getCorrelativo();
            textoRecibo = textoRecibo + correlativo + "  $" + Functions.round2decimals(monto) + "\n";
            totalAbonoActual += monto;
            totalMora += mora;
            referencias = miPrestamoDet.getReferencia();
        }

        totalAbonoFinal = totalAbonoActual + totalMora;
        totalsaldoAnterior = saldoActual + totalAbonoActual;
        textoRecibo += "-------------------------------\n";
        textoRecibo += " TOTAL CUOTA(S) $: " + Functions.round2decimals(totalAbonoActual) + " \n";
        textoRecibo += " TOTAL MORA $: " + Functions.round2decimals(totalMora) + " \n";
        textoRecibo += " TOTAL PAGO $: " + Functions.round2decimals(totalAbonoFinal) + " \n";
        textoRecibo += "-------------------------------\n";
        //textoRecibo += " TOTAL ABONADO  $: " +abonadoActual + " \n";
        //textoRecibo += " SALDO ANTERIOR $ "+ totalsaldoAnterior + "\n";
        textoRecibo += " NUEVO SALDO  $: " + Functions.round2decimals(saldoActual) + " \n\n\n";

        String ref = "REF: " + referencias.toUpperCase();
        ref += "\n\n\n\n\n";

        byte[] buffer = textoRecibo.getBytes();
        byte[] PrintHeader = {(byte) 0xAA, 0x55, 2, 0};
        PrintHeader[3] = (byte) buffer.length;
        Context mCtx = getApplicationContext();
        InitPrinter(mCtx);

        if (PrintHeader.length > 128) {
            value += "\nValor mayor a 128 bits\n";
            Toast.makeText(mCtx, value, Toast.LENGTH_LONG).show();
        } else {
            try {

                // printPhoto(R.drawable.aylinversionesbn);//FUNCIONA
                // outputStream.write(PrinterCommands.SELECT_CYRILLIC_CHARACTER_CODE_TABLE);

                outputStream.flush();

                outputStream.write(PrinterCommands.ESC_ALIGN_CENTER);
                outputStream.write(PrinterCommands.SELECT_FONT_A);
                outputStream.write(PrinterCommands.BOLD_ON);
                outputStream.write(textoEncabRecibo.getBytes());
                outputStream.write(PrinterCommands.ESC_ALIGN_LEFT);
                outputStream.write(textoEncabRecibo2.getBytes());
                outputStream.write(PrinterCommands.ESC_CANCEL_BOLD);
                outputStream.write(textoRecibo.getBytes());


                outputStream.write(PrinterCommands.ESC_ALIGN_CENTER);
                outputStream.write(ref.getBytes());

                outputStream.close();
                socket.close();
            } catch (Exception ex) {
                value += ex.toString() + "\n" + "Excep IntentPrint \n";
                //Toast.makeText(mCtx, value, Toast.LENGTH_LONG).show();
            }
        }
    }

    public void InitPrinter(Context mCtx) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        try {
            if (!bluetoothAdapter.isEnabled()) {
                //  final int REQUEST_ENABLE_BT = 1;
                Intent enableBluetooth = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                //  frag_listaPedido.startActivityForResult(enableBluetooth, 0);
                startActivityForResult(enableBluetooth, 0);
            }

            Set<BluetoothDevice> pairedDevices = bluetoothAdapter.getBondedDevices();

            if (pairedDevices.size() > 0) {
                for (BluetoothDevice device : pairedDevices) {
                    if (device.getName().equals("PT200")) //Note, you will need to change this to match the name of your device
                    {
                        bluetoothDevice = device;
                        break;
                    }
                }
                BluetoothSocket socket = null;
                boolean connected = true;
                UUID uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"); //Standard SerialPortService ID

                try {
                    socket = bluetoothDevice.createRfcommSocketToServiceRecord(uuid);
                } catch (IOException e) {
                }
                try {
                    socket.connect();
                } catch (IOException e) {
                    try {
                        socket = (BluetoothSocket) bluetoothDevice.getClass().getMethod("createRfcommSocket", new Class[]{int.class})
                                .invoke(bluetoothDevice, 1);
                        socket.connect();
                    } catch (Exception e2) {
                        connected = false;
                    }
                }

                bluetoothAdapter.cancelDiscovery();
                // socket.connect();
                socket.getInputStream();
                outputStream = socket.getOutputStream();
                inputStream = socket.getInputStream();
                beginListenForData();
            } else {
                value = "No se Encuentra el Printer";
                //Toast.makeText(mCtx, value, Toast.LENGTH_LONG).show();
                return;
            }
        } catch (Exception ex) {
            value = "Error  Iniciando Printer \n" + ex.toString() + "\n";
            //Toast.makeText(mCtx, value, Toast.LENGTH_LONG).show();
        }
    }

    void beginListenForData() {
        try {
            final Handler handler = new Handler();

            // this is the ASCII code for a newline character
            final byte delimiter = 10;

            stopWorker = false;
            readBufferPosition = 0;
            readBuffer = new byte[1024];

            workerThread = new Thread(new Runnable() {
                public void run() {

                    while (!Thread.currentThread().isInterrupted() && !stopWorker) {

                        try {

                            int bytesAvailable = inputStream.available();

                            if (bytesAvailable > 0) {

                                byte[] packetBytes = new byte[bytesAvailable];
                                inputStream.read(packetBytes);

                                for (int i = 0; i < bytesAvailable; i++) {

                                    byte b = packetBytes[i];
                                    if (b == delimiter) {

                                        byte[] encodedBytes = new byte[readBufferPosition];
                                        System.arraycopy(
                                                readBuffer, 0,
                                                encodedBytes, 0,
                                                encodedBytes.length
                                        );

                                        // specify US-ASCII encoding
                                        final String data = new String(encodedBytes, "US-ASCII");
                                        readBufferPosition = 0;

                                        // tell the user data were sent to bluetooth printer device
                                        handler.post(new Runnable() {
                                            public void run() {
                                                Log.d("e", data);
                                            }
                                        });

                                    } else {
                                        readBuffer[readBufferPosition++] = b;
                                    }
                                }
                            }

                        } catch (IOException ex) {
                            stopWorker = true;
                        }

                    }
                }
            });

            workerThread.start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }

    @OnClick(R.id.btnAbonar)
    public void onViewClicked() {
    }
}
