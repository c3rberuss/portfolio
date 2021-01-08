package com.c3rberuss.crediapp.activities;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.CobrosAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Abono;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.providers.ApiProvider;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.Permisos;
import com.c3rberuss.crediapp.utils.deleteAsyncTask;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;
import butterknife.BindView;
import butterknife.ButterKnife;
import retrofit2.Response;

public class CobrosDiaActivity extends AppCompatActivity {

    @BindView(R.id.lista_cobros)
    RecyclerView listaCobros;

    CobrosAdapter adapter;
    List<CobroProcesado> cobroProcesados = new ArrayList<>();
    @BindView(R.id.lblTotalCobros)
    TextView lblTotalCobros;
    @BindView(R.id.lblTotalAbonos)
    TextView lblTotalAbonos;
    @BindView(R.id.lblTotal)
    TextView lblTotal;
    @BindView(R.id.lblRecuperaciones)
    TextView lblRecuperaciones;
    @BindView(R.id.lblMora)
    TextView lblMora;

    double cobros = 0.0;
    double abonos = 0.0;
    double recuperaciones = 0.0;
    double mora = 0.0;
    double total = 0.0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cobros_dia);
        ButterKnife.bind(this);

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);
        setTitle("Cobros realizados");


        cobroProcesados = AppDatabase.getInstance(this).getCobrosProcesados().getAllJoin(AppDatabase.getInstance(this).getUsuarioDao().getId());
        adapter = new CobrosAdapter(this, cobroProcesados);
        listaCobros.setAdapter(adapter);

        for (CobroProcesado cp : cobroProcesados) {
            mora+=cp.getMora();
            if (cp.isAbono()) {
                abonos += cp.getMonto();
            } else if (!cp.isAbono() && cp.isRecuperacion()) {
                recuperaciones += cp.getMonto();
            } else {
                cobros += cp.getMonto();
            }
        }

        total = cobros + abonos + recuperaciones +mora;

        lblTotalCobros.setText(String.format("$%s", Functions.round2decimals(cobros)));
        lblRecuperaciones.setText(String.format("$%s", Functions.round2decimals(recuperaciones)));
        lblTotalAbonos.setText(String.format("$%s", Functions.round2decimals(abonos)));
        lblMora.setText(String.format("$%s", Functions.round2decimals(mora)));
        lblTotal.setText(String.format("$%s", Functions.round2decimals(total)));

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);

        for(int i = 0; i < menu.size(); i++){

            if(menu.getItem(i).getItemId() != R.id.update){
                menu.getItem(i).setVisible(false);
            }
        }

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        System.out.println(item.getItemId());

        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                System.out.println("Pressed");
                break;
            case R.id.update:
                System.out.println("UPDATE :)");
                new updateAsyncTask(this).execute();
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        setResult(RESULT_OK);
        super.onBackPressed();
    }

    class updateAsyncTask extends AsyncTask<Void, Void, Void> {

        Context context;
        Dialog dialog;

        public updateAsyncTask(Context context){
            this.context = context;
            dialog = Functions.progressDialog(this.context, "Actualizando cobros, espere un momento");
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            dialog.show();
        }

        @Override
        protected Void doInBackground(Void... voids) {

            final AppDatabase db = AppDatabase.getInstance(CobrosDiaActivity.this);

            try {
                Response<List<CobroProcesado>> response = ApiProvider.getWebService().obtener_cobros_realizados(db.getUsuarioDao().getId()).execute();

                if(response.isSuccessful() && response.code() == 200){
                    db.getCobrosProcesados().deleteAllSync();
                    db.getAbonoDao().deleteAllSync();
                    db.getCobrosProcesados().insert(response.body());

                    for (CobroProcesado cp: response.body()){
                        if(cp.isAbono()){
                            final Abono tmp = new Abono();
                            tmp.setId_prestamo(cp.getId_prestamo());
                            tmp.setHora(cp.getHora());
                            tmp.setFecha(cp.getFecha());
                            tmp.setUsuario_abono(cp.getId_usuario());
                            tmp.setValor(cp.getMonto());
                            tmp.setSincronizado(true);
                            tmp.setCaja(0);
                            tmp.setId_detalle(cp.getId_detalle());

                            db.getAbonoDao().insert(tmp);
                        }
                    }


                    System.out.println("SI SE DESCARGARON LOS COBROS");
                }

            } catch (IOException e) {
                e.printStackTrace();
            }

            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            dialog.dismiss();
        }
    }

}
