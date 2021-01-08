package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.PrestamoDetalleAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.AbonoDao;
import com.c3rberuss.crediapp.database.dao.CobroProcesadoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDao;
import com.c3rberuss.crediapp.database.dao.PrestamoDetalleDao;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.utils.ArgType;
import com.c3rberuss.crediapp.utils.DialogoAbonoMonto;
import com.c3rberuss.crediapp.utils.Functions;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

public class PrestamoDetalleActivity extends AppCompatActivity {

    RecyclerView recycler;
    PrestamoDetalleAdapter adapter;
    List<PrestamoDetalle> clientes = new ArrayList<>();
    int id_prestamo = 0;
    String nombreCliente = "", datoCliente = "";
    TextView lblNombCliente;
    Button btnPagar;
    Button btnAbonar;
    EditText txtCantPagar;
    private TextView lblMonto;
    private TextView lblSaldo;
    private TextView lblUltimoPago;
    private TextView lblDiasMora;
    private TextView lblMoraPrestamo;
    private int qty = 1;
    private TextView cantidad;
    private Prestamo prestamo;
    //DialogoAbono dialogoAbono;
    DialogoAbonoMonto dialogoAbono;
    Dialog process_dialog;

    AbonoDao abonoDao;
    PrestamoDao prestamoDao;
    PrestamoDetalleDao prestamoDetalleDao;
    CobroProcesadoDao cobroProcesadoDao;
    String saldoPrestamo = "0.0";
    String montoPrestamo = "0.0";
    double moraCobro = 0;
    double cuotasCobro = 0;
    double saldoPrestamoConMora = 0.0;
    boolean tieneMora = false;
    float moraPrestamo = 0;
    int posDetMora = -1;

    int ncuotas = 0;
    double totalAbonado = 0;


    List<PrestamoDetalle> cuotasAbonar = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_prestamo_detalle);

        setTitle("Cuotas del préstamo");
        abonoDao = AppDatabase.getInstance(PrestamoDetalleActivity.this).getAbonoDao();
        prestamoDao = AppDatabase.getInstance(PrestamoDetalleActivity.this).prestamoDao();
        prestamoDetalleDao = AppDatabase.getInstance(PrestamoDetalleActivity.this).prestamoDetalleDao();
        cobroProcesadoDao = AppDatabase.getInstance(PrestamoDetalleActivity.this).getCobrosProcesados();

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);


        cantidad = findViewById(R.id.lblCantidadDetalle);
        btnAbonar = findViewById(R.id.btnAbonar);

        recycler = findViewById(R.id.lista_clientes);
        lblNombCliente = findViewById(R.id.lblNombCliente);
        btnPagar = findViewById(R.id.btnPagar);
        txtCantPagar = findViewById(R.id.txtCantPagar);
        lblMonto = findViewById(R.id.lblMontoPrestamo);
        lblSaldo = findViewById(R.id.lblSaldoPrestamo);
        lblUltimoPago = findViewById(R.id.lblUltimoPago);
        lblDiasMora = findViewById(R.id.lblDiasMora);
        lblMoraPrestamo = findViewById(R.id.lblMoraPrestamo);


        Intent iin = getIntent();
        Bundle b = iin.getExtras();

        process_dialog = Functions.progressDialog(this, "Cargando datos...");

        if (b != null) {

            id_prestamo = b.getInt("id_prestamo");
            nombreCliente = b.getString("nombre");

            saldoPrestamo = b.getString("saldo");
            montoPrestamo = b.getString("monto");
            final String ultimo_pago = b.getString("ultimo_pago");

            datoCliente = nombreCliente;
            lblMonto.setText(Functions.format("Monto: $", montoPrestamo, ArgType.string));
            lblSaldo.setText(Functions.format("Saldo: $", saldoPrestamo, ArgType.string));

            lblUltimoPago.setText(Functions.format("Último pago: ", ultimo_pago, ArgType.string));

            lblNombCliente.setText(datoCliente);

            clientes = (List<PrestamoDetalle>) b.getSerializable("cuotas");

            //plan = AppDatabase.getInstance(this).getPlanesDao().get(AppDatabase.getInstance(this).prestamoDao().getIdPlan(id_prestamo));
            prestamo = AppDatabase.getInstance(this).prestamoDao().getPrestamo_(id_prestamo);
            final Mora mora = AppDatabase.getInstance(PrestamoDetalleActivity.this)
                    .prestamoDao().getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

            for (PrestamoDetalle pd : clientes) {
                pd = Functions.tieneMoraNew(pd, mora, prestamo.getProxima_mora());

                if (pd.isTiene_mora()) {
                    lblDiasMora.setText(Functions.format("Dias mora: ", pd.getDias_mora(), ArgType.integer));
                    lblMoraPrestamo.setText(Functions.format("Mora: $", Functions.round2decimals(pd.getMora()), ArgType.string));
                    tieneMora = true;
                    moraPrestamo = (float) pd.getMora();
                    posDetMora = clientes.indexOf(pd);
                    clientes.set(clientes.indexOf(pd), pd);
                    break;
                }
            }

        } else {
            Log.e("EXTRAS", "ES NULL");
        }


        Log.e("ID PRESTAMO", String.valueOf(id_prestamo));


        adapter = new PrestamoDetalleAdapter(getApplicationContext(), clientes, prestamo, 0);
        recycler.setAdapter(adapter);

        final Dialog dialog_ = Functions.progressDialog(this, "Cargando datos...");
        dialog_.show();

        for (PrestamoDetalle d : clientes) {
            saldoPrestamoConMora += (d.getMonto() + d.getMora() - d.getAbono());
        }

        //adapter.swapData(clientes);
        adapter.seleccionar(cantidad.getText().toString());
        if (dialog_.isShowing()) {
            dialog_.dismiss();
        }

        if (clientes.size() > 0) {

            double mora = posDetMora >= 0 ? clientes.get(posDetMora).getMora() : 0.0;

            dialogoAbono = new DialogoAbonoMonto(PrestamoDetalleActivity.this, (float) prestamo.getSaldo(), (float) mora, efectivo -> {

                process_dialog.show();

                ncuotas = 0;//(int) Math.round(efectivo/prestamo.getCuota());
                moraCobro = 0;
                cuotasCobro = 0;
                totalAbonado = 0;
                double abono = 0;
                cuotasAbonar.clear();


                if (efectivo > saldoPrestamoConMora) {
                    efectivo = saldoPrestamoConMora;//prestamo.getSaldo();
                    abono = saldoPrestamoConMora;
                }

                dividirEfectivoCuotas(clientes.get(0), efectivo);

                double val = 0;

                for (PrestamoDetalle p : cuotasAbonar) {
                    if (cuotasAbonar.indexOf(p) != cuotasAbonar.size() - 1) {
                        val += (p.getMonto() + p.getMora() - p.getAbono());
                    }
                }

                Log.e("VAL", String.valueOf(val));

                Log.e("NCUOTAS", String.valueOf(ncuotas));

                String nombrecliente = lblNombCliente.getText().toString();
                Intent intent = new Intent(this, PagoCuotaMontoActivity.class);
                intent.putExtra("id_prestamo", id_prestamo);
                intent.putExtra("nombre", nombrecliente);
                intent.putExtra("cliente", this.nombreCliente);
                intent.putExtra("ncuotas", ncuotas);
                intent.putExtra("abono", totalAbonado);
                intent.putExtra("total_abonado", totalAbonado);
                intent.putExtra("tcuotas", cuotasCobro);
                intent.putExtra("tmora", moraCobro);
                intent.putExtra("cuotas", (Serializable) cuotasAbonar);

                process_dialog.dismiss();

                Log.e("TOTAL ABONADO", String.valueOf(totalAbonado));
                Log.e("TOTAL ABONADO 2", String.valueOf(abono));

                if (ncuotas == cuotasAbonar.size() && Double.valueOf(Functions.round2decimals(cuotasCobro + moraCobro + totalAbonado)).equals(Double.valueOf(Functions.round2decimals(efectivo)))) {
                    if (cuotasCobro < 0) {
                        totalAbonado = totalAbonado + cuotasCobro;
                        cuotasCobro = 0;

                        intent.putExtra("abono", totalAbonado);
                        intent.putExtra("tcuotas", cuotasCobro);
                    }

                    startActivityForResult(intent, 666);
                } else {
                    Log.e("COMP", Functions.round2decimals(cuotasCobro + moraCobro + totalAbonado) + " == " + Functions.round2decimals(efectivo));
                }

                Log.e("LISTA", String.valueOf(cuotasAbonar.size()));

                cuotasAbonar.clear();
            });

            btnAbonar.setOnClickListener(v -> dialogoAbono.show());
        }

    }

    void dividirEfectivoCuotas(PrestamoDetalle cuota, double efectivo) {

        System.out.println(clientes.indexOf(cuota));

        int index = clientes.indexOf(cuota);


        if (index < clientes.size()) {

            Log.e("MORA COBRO", String.valueOf(moraCobro));
            Log.e("CUOTAS COBRO", String.valueOf(cuotasCobro));
            Log.e("TOTAL ABONADO", String.valueOf(totalAbonado));

            if(posDetMora >= 0 && index == posDetMora &&  efectivo == cuota.getMora()){

                moraCobro += cuota.getMora();
                ncuotas++;
                totalAbonado = 0;
                efectivo = 0;
                cuotasCobro = 0.0;
                cuota.setSolo_mora(true);
                cuotasAbonar.add(cuota);
                System.out.println("CASE 1");

            }else{
                if (efectivo < (cuota.getMora() + cuota.getMonto() - cuota.getAbono())) {
                    ncuotas++;
                    efectivo-=cuota.getMora();
                    totalAbonado+= efectivo;
                    cuota.setMonto_abono(efectivo);
                    moraCobro += cuota.getMora();
                    efectivo = 0;
                    cuotasAbonar.add(cuota);
                    System.out.println("CASE 2");
                }else if (efectivo >= (cuota.getMora() + cuota.getMonto() - cuota.getAbono())) {

                    ncuotas++;
                    efectivo -= cuota.getMora();
                    moraCobro += cuota.getMora();
                    efectivo -= cuota.getMonto() - cuota.getAbono();
                    cuotasCobro += cuota.getMonto() - cuota.getAbono();
                    cuota.setPagado(1);
                    cuota.setMonto_abono(0);
                    cuotasAbonar.add(cuota);
                    System.out.println("CASE 3");
                }else {
                    ncuotas++;
                    if(Functions.round2decimals(efectivo).equals(Functions.round2decimals((cuota.getMonto() - cuota.getAbono())))){
                        cuotasCobro+= efectivo;
                        cuota.setPagado(1);
                    }else{
                        totalAbonado = efectivo;
                        cuota.setMonto_abono(efectivo);
                    }

                    efectivo = 0;
                    cuotasAbonar.add(cuota);
                    System.out.println("CASE 4");
                }
            }

            Log.e("EFECTIVO RES", String.valueOf(efectivo));

            if (efectivo > 0) {
                if (index < clientes.size()) {
                    index++;

                    dividirEfectivoCuotas(clientes.get(index), efectivo);
                }
            }

        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == 666 && resultCode == RESULT_OK) {

            AppDatabase.getInstance(this).
                    prestamoDetalleDao()
                    .getByIdPrestamoDetalle2(id_prestamo).observe(this, prestamoDetalles -> {

                adapter.swapData(prestamoDetalles);
                adapter.seleccionar("1");
                qty = 1;
                cantidad.setText(Functions.intToString2Digits(qty));

                setResult(RESULT_OK);
                finish();
            });

        }

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            setResult(RESULT_OK);
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }


    @Override
    public void onBackPressed() {
        setResult(RESULT_OK);
        super.onBackPressed();
    }
}
