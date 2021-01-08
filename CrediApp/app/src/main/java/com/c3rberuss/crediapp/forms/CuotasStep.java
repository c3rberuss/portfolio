package com.c3rberuss.crediapp.forms;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Switch;
import android.widget.TextView;

import com.c3rberuss.crediapp.activities.ListaCuotasActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.SolicitudCreditoActivity;
import com.c3rberuss.crediapp.adapters.HintFrecuenciaAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Plan;
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

import ernestoyaquello.com.verticalstepperform.Step;

public class CuotasStep extends Step<HashMap<String, Object>> {

    private Context context;
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
    private Switch distribuir;
    private TextInputEditText costoContrato;
    private Plan plan;
    private List<String> fechas = new ArrayList<>();

    private static final String CERO = "0";
    private static final String BARRA = "/";

    //Calendario para obtener fecha & hora
    public final Calendar c = Calendar.getInstance();

    //Variables para obtener la fecha
    int mes = c.get(Calendar.MONTH);
    int dia = c.get(Calendar.DAY_OF_MONTH);
    int anio = c.get(Calendar.YEAR);

    public CuotasStep(String title, Context context) {
        super(title);
        this.context = context;
    }

    protected CuotasStep(String title, String subtitle, Context context) {
        super(title, subtitle);
        this.context = context;
    }

    protected CuotasStep(String title, String subtitle, String nextButtonText, Context context) {
        super(title, subtitle, nextButtonText);
        this.context = context;
    }

    @Override
    public HashMap<String, Object> getStepData() {

        final HashMap<String, Object> f = new HashMap<>();

        final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();

        try {
            c.setTime(sdf.parse(Functions.fechaDMY(fecha_inicial.getText().toString())));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if(!this.ncuotas.getText().toString().isEmpty() && !this.monto.getText().toString().isEmpty() &&
            !this.lbl_monto_final.getText().toString().isEmpty() && !this.porcentaje.getText().toString().isEmpty()){

            fechas = calcularFechas(this.n_frecuencia, Integer.valueOf(this.ncuotas.getText().toString()), c);

            f.put("fechas", fechas);
            f.put("cuota", Float.valueOf(this.lbl_cuota.getText().toString().replace(",","")));
            f.put("cuotas", Float.valueOf(this.ncuotas.getText().toString().replace(",", "")));
            f.put("final", Float.valueOf(this.lbl_monto_final.getText().toString().replace(",", "")));
            f.put("monto", Float.valueOf(this.monto.getText().toString().replace(",", "")));
            f.put("frecuencia", frecuencias.get(n_frecuencia).getId());
            f.put("porcentaje", Float.valueOf(this.porcentaje.getText().toString().replace(",", "")));
            f.put("fecha_inicial", Functions.fechaYMD(this.fecha_inicial.getText().toString()));
            f.put("divcontrato", this.distribuir.isChecked());

        }

        return f;
    }

    @Override
    public String getStepDataAsHumanReadableString() {
        return null;
    }

    @Override
    public void restoreStepData(HashMap<String, Object> data) {

    }

    @Override
    protected IsDataValid isStepDataValid(HashMap<String, Object> stepData) {

        if(monto.getText().toString().isEmpty()){
            return new IsDataValid(false);
        }

        if(ncuotas.getText().toString().isEmpty()){
            return new IsDataValid(false);
        }

        if(porcentaje.getText().toString().isEmpty()){
            return new IsDataValid(false);
        }

        if(n_frecuencia < 0){
            return new IsDataValid(false);
        }


        return new IsDataValid(true);
    }

    @Override
    protected View createStepContentLayout() {

        LayoutInflater inflater = LayoutInflater.from(this.context);

        View view = inflater.inflate(R.layout.cuotas_layout_step, null, false);

        this.monto = view.findViewById(R.id.txtMonto2);
        this.porcentaje = view.findViewById(R.id.txtPorcentaje);
        this.ncuotas = view.findViewById(R.id.txtNCuotas);
        this.lbl_cuota = view.findViewById(R.id.lblCuotaFinal);
        this.lbl_monto_final = view.findViewById(R.id.lblMontoFinal);
        this.fecha_inicial = view.findViewById(R.id.txtFechaInicial);
        this.mostrarCuotas = view.findViewById(R.id.btnMostrarCuotas);
        this.distribuir = view.findViewById(R.id.distribuirContrato);
        this.costoContrato = view.findViewById(R.id.txtPrecioContrato);

        view.findViewById(R.id.layout_interes).setVisibility(View.GONE);

        this.distribuir.setOnCheckedChangeListener((buttonView, isChecked) -> {

            if(isChecked && plan != null){

                final double monto_ = Double.valueOf(CuotasStep.this.monto.getText().toString()) + plan.getValor_contrato();

                changeValues( String.valueOf(CuotasStep.this.monto.getText().toString()),
                        CuotasStep.this.ncuotas.getText().toString(),
                        CuotasStep.this.porcentaje.getText().toString(),
                        frecuencias.get(n_frecuencia));
            }else if(!isChecked && plan != null){
                changeValues( String.valueOf(CuotasStep.this.monto.getText().toString()),
                        CuotasStep.this.ncuotas.getText().toString(),
                        CuotasStep.this.porcentaje.getText().toString(),
                        frecuencias.get(n_frecuencia));
            }

        });

        this.mostrarCuotas.setEnabled(false);

        final String d = Functions.intToString2Digits(dia);
        final String m = Functions.intToString2Digits((mes+1));
        final String f = String.valueOf(anio)+"-"+m+"-"+d;

        this.fecha_inicial.setText(Functions.fechaDMY(f));

        frecuencia2 = view.findViewById(R.id.spinner_frecuencia2);
        adapter = new HintFrecuenciaAdapter(this.context, frecuencias, "Frecuencia");
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

                markAsCompletedOrUncompleted(true);

                if(n_frecuencia > -1){

                    String monto = s.toString().equals(".") ? "0.0" : s.toString();

                    monto = s.toString().startsWith(".") ? "0"+s.toString() : s.toString();
                    monto = s.toString().isEmpty() ? "0.0" : s.toString();

                    changeValues(monto.replace(",", ""),
                            CuotasStep.this.ncuotas.getText().toString().replace(",", ""),
                            CuotasStep.this.porcentaje.getText().toString(),
                            frecuencias.get(n_frecuencia));

                    mostrarCuotas.setEnabled(true);
                }else{
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

                markAsCompletedOrUncompleted(true);

                if(n_frecuencia > -1){
                    final String porcentaje = s.toString().isEmpty() ? "0.0" : s.toString();

                    changeValues( CuotasStep.this.monto.getText().toString().replace(",", ""),
                            CuotasStep.this.ncuotas.getText().toString().replace(",", ""),
                            porcentaje, frecuencias.get(n_frecuencia));

                    mostrarCuotas.setEnabled(true);
                }else{
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

                markAsCompletedOrUncompleted(true);

                if(n_frecuencia > -1){
                    final String ncuotas = s.toString().isEmpty() ? "0" : s.toString();

                    changeValues( CuotasStep.this.monto.getText().toString().replace(",", ""),
                            ncuotas.replace(",", ""),
                            CuotasStep.this.porcentaje.getText().toString(),
                            frecuencias.get(n_frecuencia));
                    mostrarCuotas.setEnabled(true);
                }else{
                    mostrarCuotas.setEnabled(false);
                }

            }
        };

        this.ncuotas.addTextChangedListener(watcherNcuotas);

        this.fecha_inicial.setOnFocusChangeListener((v, hasFocus) -> {
            if(hasFocus){
                obtenerFecha();
            }
        });

        frecuencia2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                n_frecuencia = position;
                System.out.println("FRECUENCIA: "+frecuencias.get(position).getNombre());
                mostrarCuotas.setEnabled(true);
                changeValues( CuotasStep.this.monto.getText().toString(),
                        CuotasStep.this.ncuotas.getText().toString(),
                        CuotasStep.this.porcentaje.getText().toString(),
                        frecuencias.get(position));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                System.out.println("Nada seleccionado");
            }
        });

        this.mostrarCuotas.setOnClickListener(v->{

            if(monto.getText().toString().length() > 0 && ncuotas.getText().toString().length() > 0 &&
                porcentaje.getText().toString().length() > 0 ){

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Calendar c = Calendar.getInstance();
                try{
                    //Setting the date to the given date
                    c.setTime(sdf.parse(Functions.fechaDMY(fecha_inicial.getText().toString())));
                    //Log.d("DAY", String.valueOf());

                    fechas = calcularFechas(this.n_frecuencia, Integer.valueOf(this.ncuotas.getText().toString()), c);

                    Intent intent = new Intent(this.context, ListaCuotasActivity.class);
                    Bundle bundle = new Bundle();

                    final double c_ = Double.parseDouble(this.lbl_cuota.getText().toString().replace(",",""));
                    final double m_ = Double.parseDouble(this.monto.getText().toString().replace(",", ""));

                    bundle.putSerializable("cuotas", (Serializable) fechas);
                    bundle.putBoolean("solointeres", SolicitudCreditoActivity.planesStep.getStepData().isSolointeres());
                    bundle.putDouble("cuota", c_);
                    bundle.putDouble("monto", m_);

                    intent.putExtras(bundle);

                    this.context.startActivity(intent);

                }catch(ParseException e){
                    e.printStackTrace();
                }

            }

        });


        return view;
    }

    @Override
    protected void onStepOpened(boolean animated) {
        this.monto.requestFocus();
        this.plan = SolicitudCreditoActivity.planesStep.getStepData();

        markAsCompletedOrUncompleted(true);

        if(plan != null){

            if(plan.getValor_contrato() == 0.0){
                distribuir.setEnabled(false);
            }else{
                distribuir.setEnabled(true);
            }

            final String costo = "$"+String.valueOf(plan.getValor_contrato());
            this.costoContrato.setText(costo);
            this.frecuencia2.setSelection(plan.getFrecuencia(), true);
            this.porcentaje.setText(String.valueOf(plan.getPorcentaje()));

            final HashMap<String, Object> info = SolicitudCreditoActivity.infoStep.getStepData();

            if(info != null){
                this.monto.setText(info.get("monto").toString());
            }
        }
    }

    @Override
    protected void onStepClosed(boolean animated) {

    }

    @Override
    protected void onStepMarkedAsCompleted(boolean animated) {

    }

    @Override
    protected void onStepMarkedAsUncompleted(boolean animated) {

    }


    private void changeValues(String monto, String ncuotas, String porcent, Frecuencia frecuencia){

        final DecimalFormat df = new DecimalFormat("###,###,###.##");
        df.setRoundingMode(RoundingMode.HALF_UP);

        monto = monto.equals(".") ? "0" : monto;
        monto = monto.isEmpty() ? "0" : monto;
        monto = monto.startsWith(".") ? "0"+monto : monto;

        porcent = porcent.isEmpty() ? "0" : porcent;
        ncuotas = ncuotas.isEmpty() ? "0" : ncuotas;

        int proporcion = (int) Math.ceil(Float.valueOf(ncuotas)/ (float) frecuencia.getProporcion());

        Log.i("NCUOTAS", ncuotas);
        Log.i("FRECUENCIA", String.valueOf(frecuencia.getProporcion()));

        final HashMap<String, Float> calc_ = Functions.calcularMontoCuota(
                Float.valueOf(monto.replace(",", "")),
                Float.valueOf(porcent.replace(",", "")),
                Float.valueOf(ncuotas.replace(",", "")),
                proporcion,
                SolicitudCreditoActivity.planesStep.getStepData().isSolointeres()
                );

        if(distribuir.isChecked()){
            this.lbl_monto_final.setText(df.format(calc_.get("monto_final") + plan.getValor_contrato()));
        }else{
            this.lbl_monto_final.setText(df.format(calc_.get("monto_final")));
        }

        if(n_frecuencia >= 0){
            if(Double.parseDouble(ncuotas) < 1){
                this.lbl_cuota.setText("0.0");
            }else{
                //this.lbl_cuota.setText(df.format(calc/Double.parseDouble(ncuotas)));

                if(SolicitudCreditoActivity.planesStep.getStepData().isSolointeres()){

                    final float m_f = Functions.getValueFormat(calc_.get("cuota")) * Float.valueOf(ncuotas);

                    monto_final = m_f + calc_.get("monto_original");
                }else{
                    monto_final = Float.valueOf(df.format(calc_.get("cuota")).replace(",", "")) * Float.valueOf(ncuotas);
                }

                if(distribuir.isChecked()){
                    monto_final+=plan.getValor_contrato();
                    this.lbl_cuota.setText(String.valueOf(df.format(calc_.get("cuota")+(plan.getValor_contrato()/Float.valueOf(ncuotas)))));
                }else{
                    this.lbl_cuota.setText(String.valueOf(df.format(calc_.get("cuota"))));
                }

                this.lbl_monto_final.setText(String.valueOf(df.format(monto_final)));
            }
        }

    }

    private void obtenerFecha(){

        DatePickerDialog recogerFecha = new DatePickerDialog((Activity)this.context, (view, year, month, dayOfMonth) -> {

            final int mesActual = month + 1;

            String diaFormateado = (dayOfMonth < 10)? CERO + String.valueOf(dayOfMonth):String.valueOf(dayOfMonth);

            String mesFormateado = (mesActual < 10)? CERO + String.valueOf(mesActual):String.valueOf(mesActual);

            CuotasStep.this.dia = dayOfMonth;
            CuotasStep.this.mes = month;
            CuotasStep.this.anio = year;

            final String fecha = year+"-"+mesFormateado+"-"+diaFormateado;
            CuotasStep.this.fecha_inicial.setText(Functions.fechaDMY(fecha));


        },anio, mes, dia);

        recogerFecha.show();

    }

    private List<String> calcularFechas(int frecuencia, int ncuotas, Calendar calendar_){

        List<String> fechas = new ArrayList<>();

        int field = 0;
        int increment = 0;

        System.out.println(Calendar.DAY_OF_MONTH);

        switch (frecuencia+1){
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

        while(calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY || calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY){
            calendar_.add(Calendar.DAY_OF_MONTH, 1);
        }

        final String f2  = Functions.numbersToDate(calendar_.get(Calendar.DAY_OF_MONTH), calendar_.get(Calendar.MONTH), calendar_.get(Calendar.YEAR));

        fechas.add(f2);

        Log.d("FECHA", f2);

        for(int i = 1; i<=ncuotas-1; i++){

            calendar_.add(field, increment);

            while(calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY || calendar_.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY){
                calendar_.add(Calendar.DAY_OF_MONTH, 1);
            }

            final String f  = Functions.numbersToDate(calendar_.get(Calendar.DAY_OF_MONTH), calendar_.get(Calendar.MONTH), calendar_.get(Calendar.YEAR));
            Log.d("FECHA", f);
            fechas.add(f);
        }

        return fechas;
    }

    private void obtener_frecuencias(){
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

        frecuencias.clear();
        frecuencias.addAll(AppDatabase.getInstance(context).getFrecuenciaDao().getAll());
        adapter.notifyDataSetChanged();
    }
}
