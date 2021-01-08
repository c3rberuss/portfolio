package com.c3rberuss.crediapp.forms;

import android.app.Activity;
import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.adapters.HintFrecuenciaAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.utils.Dialogs;
import com.developer.kalert.KAlertDialog;
import com.google.android.material.textfield.TextInputEditText;
import com.jaiselrahman.hintspinner.HintSpinner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import ernestoyaquello.com.verticalstepperform.Step;
import jrizani.jrspinner.JRSpinner;

public class InformacionGeneralStep extends Step<HashMap<String, Object>> {

    private Context contex;
    private HintSpinner frecuencia;
    private HintFrecuenciaAdapter adapter;
    private List<Frecuencia> frecuencias = new ArrayList<>();
    private  JRSpinner spinner_clientes;
    private TextInputEditText monto, destino;
    private String[]  clientes;
    private List<Cliente> clienteList = new ArrayList<>();
    private Cliente cliente_seleccionado;
    private Frecuencia frecuencia_seleccionada;
    private AppDatabase db;

    public InformacionGeneralStep(String title, Context context) {
        super(title);
        this.contex = context;
    }

    protected InformacionGeneralStep(String title, String subtitle, Context context) {
        super(title, subtitle);
        this.contex = context;

    }

    protected InformacionGeneralStep(String title, String subtitle, String nextButtonText, Context context) {
        super(title, subtitle, nextButtonText);
        this.contex = context;
    }

    @Override
    public HashMap<String, Object> getStepData() {

        final HashMap<String, Object> data = new HashMap<>();

        if(frecuencia_seleccionada !=  null && cliente_seleccionado != null &&
                !monto.getText().toString().isEmpty() && !destino.getText().toString().isEmpty()){
            data.put("cliente", cliente_seleccionado);

            String monto_ = monto.getText().toString();
            monto_= monto_.isEmpty() ? "0" : monto_;
            monto_ = monto_.startsWith(".") ? "0"+monto_ : monto_;
            monto_ = monto_.equals(".") ? "0" :monto_;

            data.put("monto", monto_);
            data.put("frecuencia", frecuencia_seleccionada);
            data.put("destino", destino.getText().toString());
        }

        return data;
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

        boolean valid = false;
        String error = "";

        if(stepData.get("cliente") == null){
            error = "El cliente es requerido. Seleccione uno";
            return new IsDataValid(valid);
        }

        if(((String)stepData.get("destino")).isEmpty()){
            error = "El Monto es requerido. Ingrese uno.";
            return new IsDataValid(valid);
        }

        if(((String)stepData.get("monto")).isEmpty()){
            error = "El Monto es requerido. Ingrese uno.";
            return new IsDataValid(valid);
        }else if(Double.parseDouble(((String)stepData.get("monto"))) < 1 ){
            error = "El Monto debe de ser mayor a 0";
            return new IsDataValid(valid);
        }

        if(stepData.get("frecuencia") == null){
            error = "La frecuencia de pago es requerida. Seleccione una.";
            return new IsDataValid(valid);
        }

        valid = true;

        System.out.println("IS VALID");

        markAsCompleted(valid);

        return new IsDataValid(valid);
    }

    @Override
    protected View createStepContentLayout() {

        LayoutInflater inflater = LayoutInflater.from(this.contex);
        final View view = inflater.inflate(R.layout.informacion_general_step, null, false);

        frecuencia = view.findViewById(R.id.spinner_frecuencia);
        adapter = new HintFrecuenciaAdapter(this.contex, frecuencias, "Frecuencia");
        frecuencia.setAdapter(adapter);
        monto = view.findViewById(R.id.txtMonto);
        destino = view.findViewById(R.id.txtDestino);

        db = AppDatabase.getInstance(contex);

        obtener_frecuencias();

        spinner_clientes = view.findViewById(R.id.spinner_clientes);
        spinner_clientes.setMultiple(false);

        spinner_clientes.setOnItemClickListener(position -> {

            if(!clienteList.get(position).isVetado()){
                cliente_seleccionado = clienteList.get(position);
                isStepDataValid(getStepData());
            }else{
                Dialogs.error(this.contex,
                        "Cliente Vetado",
                        "El cliente se encuentra Vetado.",
                        d->{
                            ((Activity)this.contex).finish();
                            d.dismiss();
                        }).show();

            }
        });

/*        MainActivity.ws.get_clientes().enqueue(new Callback<List<Cliente>>() {
            @Override
            public void onResponse(Call<List<Cliente>> call, Response<List<Cliente>> response) {
                if(response.code() == 200){

                    clientes = new String[response.body().size()];

                    clienteList = response.body();

                    for(Cliente c: response.body()){
                        clientes[response.body().indexOf(c)] = c.getNombre();
                    }

                    spinner_clientes.setItems(clientes);

                }
            }

            @Override
            public void onFailure(Call<List<Cliente>> call, Throwable t) {

            }
        });*/


        clienteList.clear();
        clienteList.addAll(AppDatabase.getInstance(contex).getClienteDao().getAll_());

        clientes = new String[clienteList.size()];

        for(Cliente c: clienteList){
            clientes[clienteList.indexOf(c)] = c.getNombre();
        }

        spinner_clientes.setItems(clientes);


        frecuencia.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                frecuencia_seleccionada = frecuencias.get(position);
                isStepDataValid(getStepData());
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        TextWatcher watcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                markAsCompletedOrUncompleted(true);

                /*if (isStepDataValid(getStepData()).isValid()){
                    markAsCompleted(true);
                }else{

                }*/
            }
        };

        monto.addTextChangedListener(watcher);
        destino.addTextChangedListener(watcher);

        return view;
    }

    @Override
    protected void onStepOpened(boolean animated) {

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

    private void obtener_frecuencias(){
/*        MainActivity.ws.get_frecuencias().enqueue(new Callback<List<Frecuencia>>() {
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
        frecuencias.addAll(db.getFrecuenciaDao().getAll());
        adapter.notifyDataSetChanged();
    }
}
