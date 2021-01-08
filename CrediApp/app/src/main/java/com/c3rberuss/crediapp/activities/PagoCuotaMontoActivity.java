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
import android.widget.ImageButton;
import android.widget.LinearLayout;
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
import com.c3rberuss.crediapp.entities.PagosMora;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.utils.DialogoEfectivo;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.PrinterCommands;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PagoCuotaMontoActivity extends AppCompatActivity {

    @BindView(R.id.lblNumCliente)
    TextView lblNumCliente;
    @BindView(R.id.lblNombCliente)
    TextView lblNombCliente;
    @BindView(R.id.linearLayoutx)
    LinearLayout linearLayoutx;
    @BindView(R.id.lblPago)
    TextView lblPago;
    @BindView(R.id.txtTotalCuotas)
    TextView txtTotalCuotas;
    @BindView(R.id.lblPago2)
    TextView lblPago2;
    @BindView(R.id.txtTotalMora)
    TextView txtTotalMora;
    @BindView(R.id.lblAbonotxt)
    TextView lblAbonotxt;
    @BindView(R.id.lblAbono)
    TextView lblAbono;
    @BindView(R.id.lblPago3)
    TextView lblPago3;
    @BindView(R.id.txtTotalFinal)
    TextView txtTotalFinal;

    int id_prestamo = 0, ncuotas = 0, id_cobrador = 0;
    double tcobro = 0, tmora = 0, tabono = 0, total = 0, efectivoRecibido = 0, totalAbonado = 0;
    String nombreCliente = "";
    String cliente = "";
    String referencia = "";
    @BindView(R.id.lista_cuotas)
    RecyclerView listaCuotas;
    @BindView(R.id.btnFinPagar)
    ImageButton btnPagar;
    @BindView(R.id.btnPrintPago)
    ImageButton btnPrintPago;
    private Prestamo prestamo;
    PrestamoDetalleAdapter adapter;

    BluetoothAdapter bluetoothAdapter;
    BluetoothSocket socket;
    BluetoothDevice bluetoothDevice;
    OutputStream outputStream;
    InputStream inputStream;
    Thread workerThread;
    byte[] readBuffer;
    int readBufferPosition;
    volatile boolean stopWorker;

    AbonoDao abonoDao;
    PrestamoDao prestamoDao;
    PrestamoDetalleDao prestamoDetalleDao;
    CobroProcesadoDao cobroProcesadoDao;

    List<PrestamoDetalle> detalles;
    DialogoEfectivo dialogoEfectivo;
    Dialog process_dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pago_cuota_monto);
        ButterKnife.bind(this);

        setTitle("Pago de Cuotas");
        final Bundle b = getIntent().getExtras();

        abonoDao = AppDatabase.getInstance(PagoCuotaMontoActivity.this).getAbonoDao();
        prestamoDao = AppDatabase.getInstance(PagoCuotaMontoActivity.this).prestamoDao();
        prestamoDetalleDao = AppDatabase.getInstance(PagoCuotaMontoActivity.this).prestamoDetalleDao();
        cobroProcesadoDao = AppDatabase.getInstance(PagoCuotaMontoActivity.this).getCobrosProcesados();

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        btnPrintPago.setEnabled(false);

        if (b != null) {
            id_prestamo = b.getInt("id_prestamo");
            nombreCliente = b.getString("nombre");
            ncuotas = b.getInt("ncuotas");
            lblNombCliente.setText(nombreCliente);
            prestamo = AppDatabase.getInstance(this).prestamoDao().getPrestamo_(id_prestamo);
            tabono = b.getDouble("abono");
            tcobro = b.getDouble("tcuotas");
            tmora = b.getDouble("tmora");

            Log.e("TOTAL ABONADO", String.valueOf(b.getDouble("total_abonado")));
            totalAbonado = b.getDouble("total_abonado");

            total = tcobro + tmora + tabono;

            lblAbono.setText(String.format("$%s", Functions.round2decimals(tabono)));
            txtTotalCuotas.setText(String.format("$%s", Functions.round2decimals(tcobro)));
            txtTotalMora.setText(String.format("$%s", Functions.round2decimals(tmora)));
            txtTotalFinal.setText(String.format("$%s", Functions.round2decimals(total)));
            id_cobrador = AppDatabase.getInstance(this).getUsuarioDao().getId();
            cliente = b.getString("cliente");
            detalles = (List<PrestamoDetalle>) b.getSerializable("cuotas");
        }


        process_dialog = Functions.progressDialog(this, "Cargando datos...");
        process_dialog.show();

       /* detalles = AppDatabase
                .getInstance(getApplicationContext())
                .prestamoDetalleDao()
                .getPrestamoDetalleByCuota(id_prestamo, ncuotas);*/

/*        for (PrestamoDetalle pd : detalles) {
            final Mora m = AppDatabase.getInstance(getApplicationContext())
                    .prestamoDao()
                    .getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

            detalles.set(detalles.indexOf(pd),
                    Functions.tieneMora(pd, m));
        }*/

        adapter = new PrestamoDetalleAdapter(this, detalles, prestamo, 1);
        listaCuotas.setAdapter(adapter);

        process_dialog.dismiss();

        dialogoEfectivo = new DialogoEfectivo(this, total, (efectivo) -> {
            efectivoRecibido = efectivo;
            realizarCobro();
            setResult(RESULT_OK);
        });
    }

    //Impresion de Recibo

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

                /*List<Prestamo> prestamo = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getByIdPrestamo(id_prestamo);

                String nombre = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getNombreCliente(id_prestamo);*/

                //IntentPrint(clientes, nombre, prestamo);


                final List<CobroProcesado> cobros = AppDatabase.getInstance(getApplicationContext())
                        .getCobrosProcesados()
                        .getAllCobrosByReferencia(referencia);


                Prestamo prestamo = AppDatabase
                        .getInstance(getApplicationContext())
                        .prestamoDao().getPrestamo_(id_prestamo);

                IntentPrint2(cobros, prestamo);

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
                //value = "No se Encuentra el Printer";
                //Toast.makeText(mCtx, value, Toast.LENGTH_LONG).show();
                return;
            }
        } catch (Exception ex) {
            //value = "Error  Iniciando Printer \n" + ex.toString() + "\n";
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
                                        final String data = new String(encodedBytes, StandardCharsets.US_ASCII);
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

    @OnClick({R.id.btnFinPagar, R.id.btnPrintPago})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btnFinPagar:
                dialogoEfectivo.show();
                break;
            case R.id.btnPrintPago:
                printPagocuota(id_prestamo);
                break;
        }
    }

    private void realizarCobro() {

        process_dialog = Functions.progressDialog(this, "Procesando transacción, espere...");
        process_dialog.show();

        prestamo.setSincronizado(false);

        referencia = Functions.uniqid("", false);

        boolean soloMora = false;

        for (PrestamoDetalle pd : detalles) {

            Log.e("REPEAT CUOTAS", "YEP");

            final CobroProcesado cobroProcesado = new CobroProcesado(1, id_prestamo, id_cobrador);
            cobroProcesado.setSincronizado(false);
            cobroProcesado.setId_detalle(pd.getId_detalle());
            cobroProcesado.setId_prestamo(id_prestamo);
            cobroProcesado.setCuota(pd.getCorrelativo());
            cobroProcesado.setCliente(cliente);
            cobroProcesado.setReferencia(referencia);

            if (detalles.indexOf(pd) == 0 && pd.isSolo_mora()) {

                Log.e("SOLO MORA", "YEP");

                cobroProcesado.setSoloMora(true);
                cobroProcesado.setMonto(pd.getMora());
                cobroProcesadoDao.insert(cobroProcesado);
                soloMora = true;
                savePagoMora(pd.getId_detalle(), pd.getMora(), pd.getDias_mora());


                prestamo.setProxima_mora(Functions.proximaMora(prestamo.getId_prestamo(), this));
                prestamo.setAtrasado(Functions.nuevoEstadoAtrasado(prestamo.getId_prestamo(), this));
                prestamo.setMora(0);
                prestamo.setDias_mora(0);

                break;
            }

            pd.setSincronizado(false);

            if (pd.getPagado() == 0 && pd.getMonto_abono() > 0 && pd.getMora() > 0) {

                Log.e("ABONO CON MORA", "YEP");


                pd.setAbono(pd.getAbono() + totalAbonado);
                //pd.setAbono(pd.getAbono() + (totalAbonado - pd.getMora()));

                pd.setMonto_abono(totalAbonado);
                cobroProcesado.setMonto(totalAbonado);

                /*if(pd.getMora() > totalAbonado){
                    cobroProcesado.setMonto((totalAbonado - pd.getMora()));

                }else{
                    pd.setMonto_abono((totalAbonado - pd.getMora()));
                    cobroProcesado.setMonto((totalAbonado - pd.getMora()));

                }
*/
                pd.setAbonado(true);
                cobroProcesado.setAbono(true);
                cobroProcesado.setMora(0);

                final Abono abono = new Abono();
                abono.setSincronizado(false);
                abono.setValor(totalAbonado);
//                abono.setValor((totalAbonado - pd.getMora()));
                abono.setId_detalle(pd.getId_detalle());
                abono.setUsuario_abono(id_cobrador);
                abono.setFecha(Functions.getFecha());
                abono.setHora(Functions.getHora());
                abono.setId_prestamo(id_prestamo);
                abonoDao.insert(abono);

                final CobroProcesado cobroMora = new CobroProcesado(1, id_prestamo, id_cobrador);
                cobroMora.setSincronizado(false);
                cobroMora.setId_detalle(pd.getId_detalle());
                cobroMora.setId_prestamo(id_prestamo);
                cobroMora.setCuota(pd.getCorrelativo());
                cobroMora.setCliente(cliente);
                cobroMora.setReferencia(referencia);
                cobroMora.setPago_mora(true);
                cobroMora.setMora(pd.getMora());
                cobroProcesadoDao.insert(cobroMora);

                savePagoMora(pd.getId_detalle(), pd.getMora(), pd.getDias_mora());

                prestamo.setProxima_mora(Functions.proximaMora(prestamo.getId_prestamo(), this));
                prestamo.setAtrasado(Functions.nuevoEstadoAtrasado(prestamo.getId_prestamo(), this));
                prestamo.setMora(0);
                prestamo.setDias_mora(0);

            } else if (pd.getPagado() == 0 && pd.getMonto_abono() > 0 && pd.getMora() == 0) {

                Log.e("ABONO SIN MORA", String.valueOf(totalAbonado));

                pd.setAbono(pd.getAbono() + totalAbonado);
                pd.setMonto_abono(totalAbonado);
                pd.setAbonado(true);

                cobroProcesado.setAbono(true);
                cobroProcesado.setMonto(totalAbonado);
                cobroProcesado.setMora(0);

                final Abono abono = new Abono();
                abono.setSincronizado(false);
                abono.setValor(totalAbonado);
                abono.setId_detalle(pd.getId_detalle());
                abono.setUsuario_abono(id_cobrador);
                abono.setFecha(Functions.getFecha());
                abono.setHora(Functions.getHora());
                abono.setId_prestamo(id_prestamo);
                abonoDao.insert(abono);

            } else {

                Log.e("PAGO", "YEP");

                pd.setPagado(1);
                pd.setReferencia(referencia);
                pd.setFecha_pago(Functions.getFecha());
                pd.setHora_pago(Functions.getHora());
                pd.setId_cobrador(id_cobrador);
                pd.setEfectivo(efectivoRecibido);

                cobroProcesado.setMonto(pd.getMonto() - pd.getAbono());

                if (pd.getMora() > 0) {
                    final CobroProcesado cobroMora = new CobroProcesado(1, id_prestamo, id_cobrador);
                    cobroMora.setSincronizado(false);
                    cobroMora.setId_detalle(pd.getId_detalle());
                    cobroMora.setId_prestamo(id_prestamo);
                    cobroMora.setCuota(pd.getCorrelativo());
                    cobroMora.setCliente(cliente);
                    cobroMora.setReferencia(referencia);
                    cobroMora.setPago_mora(true);
                    cobroMora.setMora(pd.getMora());
                    cobroProcesadoDao.insert(cobroMora);

                    savePagoMora(pd.getId_detalle(), pd.getMora(), pd.getDias_mora());

                    prestamo.setProxima_mora(Functions.proximaMora(prestamo.getId_prestamo(), this));
                    prestamo.setAtrasado(Functions.nuevoEstadoAtrasado(prestamo.getId_prestamo(), this));
                    prestamo.setMora(0);
                    prestamo.setDias_mora(0);
                }

                if (pd.getAbono() != 0.0) {
                    cobroProcesado.setRecuperacion(true);
                }

            }

            prestamoDetalleDao.updatePrestamoDetalle(pd);
            cobroProcesadoDao.insert(cobroProcesado);
        }

        final double tsaldo_ = prestamo.getSaldo() - (tcobro + tabono);
        final double tabono_ = prestamo.getAbono() + (tcobro - tabono);

        prestamo.setSaldo(tsaldo_);
        prestamo.setAbono(tabono_);
        prestamoDao.updatePrestamo(prestamo);

        process_dialog.dismiss();

        btnPagar.setEnabled(false);
        btnPrintPago.setEnabled(true);
        Dialogs.printer(PagoCuotaMontoActivity.this,
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

    private void savePagoMora(int id_cuota, double mora, int dias_mora) {
        final PagosMora pagoMora = new PagosMora();

        pagoMora.setDias_mora(dias_mora);
        pagoMora.setFecha(Functions.getFecha());
        pagoMora.setHora(Functions.getHora());
        pagoMora.setValor(mora);
        pagoMora.setId_usuario(AppDatabase.getInstance(this).getUsuarioDao().getId());
        pagoMora.setId_prestamo(id_prestamo);
        pagoMora.setCorresponde(id_cuota);


        AppDatabase.getInstance(this).getPagosMoraDao().insert(pagoMora);
    }

    //impresion !!!
    public void IntentPrint2(List<CobroProcesado> cobros, Prestamo prestamo) {
        // Usuario


        String textoEncabRecibo = "", textoEncabRecibo2 = "", value = "";
        String textoRecibo = "";
        double mora = 0.0, abono = 0.0, cobro = 0.0;
        String fecha_p = Functions.getFecha();
        String fecha_pago = Functions.fechaDMY(fecha_p);
        String hora_pago = Functions.getHora();
        String nombres = Functions.removerTildes(prestamo.getNombre());

        textoEncabRecibo += "" + "\n";
        textoEncabRecibo += "CREDIAPP " + "\n\n";
        textoEncabRecibo += "COMPROBANTE DE ABONO" + "\n\n";
        textoEncabRecibo += "--------------------------------" + "\n";

        textoEncabRecibo2 += "FECHA: " + fecha_pago + "    " + hora_pago + " \n";
        //textoEncabRecibo2 += "HORA: " + hora_pago + " \n";
        textoEncabRecibo2 += "CLIENTE: " + nombres + " \n";
        textoEncabRecibo2 += "COBRADOR: " + AppDatabase.getInstance(this).getUsuarioDao().getNombre().toUpperCase();
        textoEncabRecibo2 += "--------------------------------" + "\n";
        textoEncabRecibo2 += " ABONA CUOTAS" + "\n";

        String referencias = "";

        for (CobroProcesado cp : cobros) {

            mora += cp.getMora();

            if (cp.isAbono()) {
                abono += cp.getMonto();
            } else {
                cobro += cp.getMonto();
            }

            String correlativo = " CUOTA " + cp.getCuota();
            textoRecibo = textoRecibo + correlativo + "  $" + Functions.round2decimals(cp.getMonto()) + "\n";
            //totalAbonoActual += monto;
            //totalMora += mora;
            referencias = referencia;
        }

        textoRecibo += "-------------------------------\n";
        textoRecibo += " TOTAL COBRO(S) $: " + Functions.round2decimals(cobro) + " \n";
        textoRecibo += " TOTAL MORA $: " + Functions.round2decimals(mora) + " \n";
        textoRecibo += " TOTAL ABONO(S) $: " + Functions.round2decimals(abono) + " \n";
        textoRecibo += " TOTAL PAGO $: " + Functions.round2decimals(cobro + mora + abono) + " \n";
        textoRecibo += "-------------------------------\n";
        //textoRecibo += " TOTAL ABONADO  $: " +abonadoActual + " \n";
        //textoRecibo += " SALDO ANTERIOR $ "+ totalsaldoAnterior + "\n";
        textoRecibo += " NUEVO SALDO  $: " + Functions.round2decimals(prestamo.getSaldo()) + " \n\n\n";

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

        System.out.println("IMPRESION");
        System.out.println(textoEncabRecibo);
        System.out.println(textoEncabRecibo2);
        System.out.println(textoRecibo);
        System.out.println(ref);
    }

}
