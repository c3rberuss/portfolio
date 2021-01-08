package com.c3rberuss.crediapp.activities;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Switch;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.HintFrecuenciaAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.utils.Functions;
import com.google.android.material.textfield.TextInputEditText;
import com.jaiselrahman.hintspinner.HintSpinner;

import java.io.Serializable;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

import butterknife.ButterKnife;

public class CalculadoraActivity extends AppCompatActivity {

    private TextInputEditText monto;
    private TextInputEditText porcentaje;
    private TextInputEditText ncuotas;
    private TextView lbl_monto_final;
    private TextView lbl_cuota;
    private TextInputEditText fecha_inicial;
    private float monto_final = 0.0f;
    private Double cuota = 0.0;
    private int n_frecuencia = -1;
    private HintSpinner frecuencia2;
    private HintFrecuenciaAdapter adapter;
    private Button mostrarCuotas;
    private List<Frecuencia> frecuencias = new ArrayList<>();
    private Switch interes;

    private static final String CERO = "0";
    private static final String BARRA = "/";

    //Calendario para obtener fecha & hora
    public final Calendar c = Calendar.getInstance();

    //Variables para obtener la fecha
    int mes = c.get(Calendar.MONTH);
    int dia = c.get(Calendar.DAY_OF_MONTH);
    int anio = c.get(Calendar.YEAR);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Functions.setLanguage(this);

        setContentView(R.layout.activity_calculadora);
        ButterKnife.bind(this);

        setTitle("Calcular cuotas");

        Objects.requireNonNull(getSupportActionBar()).setDisplayHomeAsUpEnabled(true);

        this.monto = findViewById(R.id.txtMonto2);
        this.porcentaje = findViewById(R.id.txtPorcentaje);
        this.ncuotas = findViewById(R.id.txtNCuotas);
        this.lbl_cuota = findViewById(R.id.lblCuotaFinal);
        this.lbl_monto_final = findViewById(R.id.lblMontoFinal);
        this.fecha_inicial = findViewById(R.id.txtFechaInicial);
        this.mostrarCuotas = findViewById(R.id.btnMostrarCuotas);
        this.interes = findViewById(R.id.switchInteres);

        findViewById(R.id.layout_interes).setVisibility(View.VISIBLE);
        findViewById(R.id.layout_distribuir).setVisibility(View.GONE);

        this.interes.setOnCheckedChangeListener((buttonView, isChecked) -> {

            if (isChecked && n_frecuencia > -1) {

                changeValues(String.valueOf(CalculadoraActivity.this.monto.getText().toString()),
                        CalculadoraActivity.this.ncuotas.getText().toString(),
                        CalculadoraActivity.this.porcentaje.getText().toString(),
                        frecuencias.get(n_frecuencia));

            } else if (!isChecked && n_frecuencia > -1) {
                changeValues(String.valueOf(CalculadoraActivity.this.monto.getText().toString()),
                        CalculadoraActivity.this.ncuotas.getText().toString(),
                        CalculadoraActivity.this.porcentaje.getText().toString(),
                        frecuencias.get(n_frecuencia));
            }

        });


        this.mostrarCuotas.setEnabled(false);

        final String d = Functions.intToString2Digits(dia);
        final String m = Functions.intToString2Digits((mes + 1));
        final String f = String.valueOf(anio) + "-" + m + "-" + d;

        this.fecha_inicial.setText(Functions.fechaDMY(f));

        frecuencia2 = findViewById(R.id.spinner_frecuencia2);
        adapter = new HintFrecuenciaAdapter(this, frecuencias, "Frecuencia");
        frecuencia2.setAdapter(adapter);


        obtener_frecuencias();


        TextWatcher watcherMonto = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                if (n_frecuencia > -1) {
                    String monto = s.toString().equals(".") ? "0.0" : s.toString();

                    monto = s.toString().startsWith(".") ? "0"+s.toString() : s.toString();
                    monto = s.toString().isEmpty() ? "0.0" : s.toString();

                    changeValues(monto,
                            CalculadoraActivity.this.ncuotas.getText().toString(),
                            CalculadoraActivity.this.porcentaje.getText().toString(),
                            frecuencias.get(n_frecuencia));

                    mostrarCuotas.setEnabled(true);
                } else {
                    mostrarCuotas.setEnabled(false);
                }
            }
        };

        this.monto.addTextChangedListener(watcherMonto);

        TextWatcher watcherPorcentaje = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                if (n_frecuencia > -1) {
                    final String porcentaje = s.toString().isEmpty() ? "0.0" : s.toString();

                    changeValues(CalculadoraActivity.this.monto.getText().toString(),
                            CalculadoraActivity.this.ncuotas.getText().toString(),
                            porcentaje, frecuencias.get(n_frecuencia));

                    mostrarCuotas.setEnabled(true);
                } else {
                    mostrarCuotas.setEnabled(false);
                }
            }
        };

        this.porcentaje.addTextChangedListener(watcherPorcentaje);

        TextWatcher watcherNcuotas = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                if (n_frecuencia > -1) {
                    final String ncuotas = s.toString().isEmpty() ? "0" : s.toString();

                    changeValues(CalculadoraActivity.this.monto.getText().toString(),
                            ncuotas,
                            CalculadoraActivity.this.porcentaje.getText().toString(),
                            frecuencias.get(n_frecuencia));
                    mostrarCuotas.setEnabled(true);
                } else {
                    mostrarCuotas.setEnabled(false);
                }

            }
        };

        this.ncuotas.addTextChangedListener(watcherNcuotas);

/*        view.findViewById(R.id.textInputLayout4).setOnClickListener(v->{
            obtenerFecha();
        });

        this.fecha_inicial.setOnClickListener((v)->{
            obtenerFecha();
        });*/

        this.fecha_inicial.setOnFocusChangeListener((v, hasFocus) -> {
            if (hasFocus) {
                obtenerFecha();
            }
        });

        frecuencia2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                n_frecuencia = position;
                System.out.println("FRECUENCIA: " + frecuencias.get(position).getNombre());
                mostrarCuotas.setEnabled(true);
                changeValues(CalculadoraActivity.this.monto.getText().toString(),
                        CalculadoraActivity.this.ncuotas.getText().toString(),
                        CalculadoraActivity.this.porcentaje.getText().toString(),
                        frecuencias.get(position));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                System.out.println("Nada seleccionado");
            }

        });

        this.mostrarCuotas.setOnClickListener(v -> {

            if (monto.getText().toString().length() > 0 && ncuotas.getText().toString().length() > 0 &&
                    porcentaje.getText().toString().length() > 0) {

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar c = Calendar.getInstance();
                try {
                    //Setting the date to the given date
                    c.setTime(sdf.parse(Functions.fechaDMY(fecha_inicial.getText().toString())));
                    //Log.d("DAY", String.valueOf());

                    List<String> fechas = calcularFechas(this.n_frecuencia, Integer.valueOf(this.ncuotas.getText().toString()), c);

                    Intent intent = new Intent(this, ListaCuotasActivity.class);
                    Bundle bundle = new Bundle();
                    bundle.putSerializable("cuotas", (Serializable) fechas);
                    bundle.putBoolean("solointeres", interes.isChecked());
                    bundle.putDouble("cuota", Double.parseDouble(this.lbl_cuota.getText().toString().replace(",", "")));
                    bundle.putDouble("monto", Double.parseDouble(this.monto.getText().toString().replace(",", "")));

                    intent.putExtras(bundle);

                    startActivity(intent);

                } catch (ParseException e) {
                    e.printStackTrace();
                }

            }

        });


    }

    private void changeValues(String monto, String ncuotas, String porcent, Frecuencia frecuencia) {

        final DecimalFormat df = new DecimalFormat("###,###,###.##");
        df.setRoundingMode(RoundingMode.HALF_UP);

        monto = monto.equals(".") ? "0" : monto;
        monto = monto.isEmpty() ? "0" : monto;
        monto = monto.startsWith(".") ? "0"+monto : monto;
        monto = monto.replace(",", "");

        porcent = porcent.isEmpty() ? "0" : porcent;
        ncuotas = ncuotas.isEmpty() ? "0" : ncuotas;
        porcent = porcent.replace(",", "");
        ncuotas =ncuotas.replace(",", "");

        int proporcion = (int) Math.ceil(Float.valueOf(ncuotas) / Float.valueOf(frecuencia.getProporcion()));


        final HashMap<String, Float> calc_ = Functions.calcularMontoCuota(
                Float.valueOf(monto),
                Float.valueOf(porcent),
                Float.valueOf(ncuotas),
                proporcion,
                interes.isChecked()
        );


        this.lbl_monto_final.setText(df.format(calc_.get("monto_final")));


        if (n_frecuencia >= 0) {
            if (Double.parseDouble(ncuotas) < 1) {
                this.lbl_cuota.setText("0.0");
            } else {
                //this.lbl_cuota.setText(df.format(calc/Double.parseDouble(ncuotas)));

                if (this.interes.isChecked()) {
                    monto_final = Float.valueOf(df.format(calc_.get("cuota")).replace(",", "")) * Float.valueOf(ncuotas) + Float.valueOf(df.format(calc_.get("monto_original")).replace(",", ""));
                } else {
                    monto_final = Float.valueOf(df.format(calc_.get("cuota")).replace(",", "")) * Float.valueOf(ncuotas);
                }

                this.lbl_cuota.setText(df.format(calc_.get("cuota")));

                this.lbl_monto_final.setText(df.format(monto_final));
            }
        }

    }

    private void obtenerFecha() {

        DatePickerDialog recogerFecha = new DatePickerDialog(this, (view, year, month, dayOfMonth) -> {

            final int mesActual = month + 1;

            String diaFormateado = (dayOfMonth < 10) ? CERO + String.valueOf(dayOfMonth) : String.valueOf(dayOfMonth);

            String mesFormateado = (mesActual < 10) ? CERO + String.valueOf(mesActual) : String.valueOf(mesActual);

            this.dia = dayOfMonth;
            this.mes = month;
            this.anio = year;

            final String fecha = year + "-" + mesFormateado + "-" + diaFormateado;
            this.fecha_inicial.setText(Functions.fechaDMY(fecha));


        }, anio, mes, dia);

        recogerFecha.show();

    }

    private List<String> calcularFechas(int frecuencia, int ncuotas, Calendar calendar_) {

        List<String> fechas = new ArrayList<>();

        int field = 0;
        int increment = 0;

        switch (frecuencia + 1) {
            case 1:
                field = Calendar.DAY_OF_MONTH;
                increment = 1;
                break;
            case 2:
                field = Calendar.DAY_OF_MONTH;
                increment = 7;
                break;
            case 3:
                field = Calendar.DAY_OF_MONTH;
                increment = 15;
                break;
            case 4:
                field = Calendar.DAY_OF_MONTH;
                increment = 30;
                break;

        }

        while (calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY || calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
            calendar_.add(Calendar.DAY_OF_MONTH, 1);
        }

        final String f2 = Functions.numbersToDate(calendar_.get(Calendar.DAY_OF_MONTH), calendar_.get(Calendar.MONTH), calendar_.get(Calendar.YEAR));

        fechas.add(f2);

        Log.d("FECHA", f2);

        for (int i = 1; i <= ncuotas - 1; i++) {

            calendar_.add(field, increment);

            while (calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY || calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
                calendar_.add(Calendar.DAY_OF_MONTH, 1);
            }

            final String f = Functions.numbersToDate(calendar_.get(Calendar.DAY_OF_MONTH), calendar_.get(Calendar.MONTH), calendar_.get(Calendar.YEAR));
            Log.d("FECHA", f);
            fechas.add(f);
        }

        return fechas;
    }

    private void obtener_frecuencias() {
       /* MainActivity.ws.get_frecuencias().enqueue(new Callback<List<Frecuencia>>() {
            @Override
            public void onResponse(Call<List<Frecuencia>> call, Response<List<Frecuencia>> response) {
                if(response.code() == 200){
                    frecuencias.clear();
                    frecuencias.addAll(response.body());
                    adapter.notifyDataSetChanged();
                }
            }

            @Override
            public void onFailure(Call<List<Frecuencia>> call, Throwable t) {

            }
        });*/

        AppDatabase.getInstance(this).getFrecuenciaDao().getAllLive().observe(this, frecuencias1 -> {
            frecuencias.clear();
            frecuencias.addAll(frecuencias1);
            adapter.notifyDataSetChanged();
        });
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }


}
