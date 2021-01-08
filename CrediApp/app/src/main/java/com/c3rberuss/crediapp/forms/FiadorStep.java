package com.c3rberuss.crediapp.forms;

import android.content.Context;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Switch;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.SolicitudCreditoActivity;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Cliente;
import com.google.android.material.textfield.TextInputEditText;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import ernestoyaquello.com.verticalstepperform.Step;
import jrizani.jrspinner.JRSpinner;

public class FiadorStep extends Step<HashMap<String, Object>> {

    private Context context;
    private Switch tieneNegocio;
    private TextInputEditText nombreNegocio;
    private TextInputEditText actividadNegocio;
    private TextInputEditText direccionNegocio;
    private JRSpinner spinner_fiadores;
    private String[]  fiadores;
    private List<Cliente> fiadoresList = new ArrayList<>();
    private Cliente fiador_seleccionado;

    public FiadorStep(String title, Context context) {
        super(title);
        this.context = context;
    }

    protected FiadorStep(String title, String subtitle, Context context) {
        super(title, subtitle);
        this.context = context;
    }

    protected FiadorStep(String title, String subtitle, String nextButtonText, Context context) {
        super(title, subtitle, nextButtonText);
        this.context = context;
    }

    @Override
    public HashMap<String, Object> getStepData() {

        final HashMap<String, Object> data = new HashMap<>();

        /*if(this.fiador_seleccionado != null){

            data.put("fiador", fiador_seleccionado);
            data.put("tiene_negocio", tieneNegocio.isChecked());
            data.put("nombre_negocio", this.nombreNegocio.getText().toString());
            data.put("actividad_negocio", this.actividadNegocio.getText().toString());
            data.put("direccion_negocio", this.direccionNegocio.getText().toString());

        }*/

        data.put("fiador", fiador_seleccionado);
        data.put("tiene_negocio", tieneNegocio.isChecked());
        data.put("nombre_negocio", this.nombreNegocio.getText().toString());
        data.put("actividad_negocio", this.actividadNegocio.getText().toString());
        data.put("direccion_negocio", this.direccionNegocio.getText().toString());

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

/*
        if(fiador_seleccionado == null){
            return new IsDataValid(false);
        }
*/

        if(tieneNegocio.isChecked()){

            if(nombreNegocio.getText().toString().isEmpty()){

                return new IsDataValid(false);

            }

            if(direccionNegocio.getText().toString().isEmpty()){
                return new IsDataValid(false);
            }

            if(actividadNegocio.getText().toString().isEmpty()){
                return new IsDataValid(false);
            }

            return new IsDataValid(true);

        }

        return new IsDataValid(true);
    }

    @Override
    protected View createStepContentLayout() {

        LayoutInflater inflater = LayoutInflater.from(this.context);

        View view = inflater.inflate(R.layout.fiador_layout_step, null, false);


        tieneNegocio = view.findViewById(R.id.switchNegocio);
        nombreNegocio = view.findViewById(R.id.txtNombreNegocio);
        actividadNegocio = view.findViewById(R.id.txtActividadNegocio);
        direccionNegocio = view.findViewById(R.id.txtDireccionNegocio);

        view.findViewById(R.id.inputs).setVisibility(View.GONE);

        tieneNegocio.setOnCheckedChangeListener((buttonView, isChecked) -> {

            markAsCompletedOrUncompleted(true);

            if(isChecked){
                view.findViewById(R.id.inputs).setVisibility(View.VISIBLE);
            }else{
                view.findViewById(R.id.inputs).setVisibility(View.GONE);
            }

        });

        spinner_fiadores = view.findViewById(R.id.spinner_fiadores);
        spinner_fiadores.setOnItemClickListener(position -> {
            fiador_seleccionado = fiadoresList.get(position);
            isStepDataValid(getStepData());
            markAsCompletedOrUncompleted(true);
        });

        /*MainActivity.ws.get_clientes().enqueue(new Callback<List<Cliente>>() {
            @Override
            public void onResponse(Call<List<Cliente>> call, Response<List<Cliente>> response) {
                if(response.code() == 200){

                    fiadores = new String[response.body().size()];

                    fiadoresList = response.body();

                    for(Cliente c: response.body()){
                        fiadores[response.body().indexOf(c)] = c.getNombre();
                    }

                    spinner_fiadores.setItems(fiadores);

                }
            }

            @Override
            public void onFailure(Call<List<Cliente>> call, Throwable t) {

            }
        });*/

        fiadoresList = AppDatabase.getInstance(context).getClienteDao().getAll_();


        fiadores = new String[fiadoresList.size()];

        for(Cliente c: fiadoresList){
            fiadores[fiadoresList.indexOf(c)] = c.getNombre();
        }
        spinner_fiadores.setItems(fiadores);


        TextWatcher watcher = new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                if(tieneNegocio.isChecked()){
                    isStepDataValid(getStepData());
                    markAsCompletedOrUncompleted(true);
                }

            }
        };

        this.nombreNegocio.addTextChangedListener(watcher);
        this.actividadNegocio.addTextChangedListener(watcher);
        this.direccionNegocio.addTextChangedListener(watcher);

        return view;
    }

    @Override
    protected void onStepOpened(boolean animated) {

        /*if(AppDatabase.getInstance(context).getPlanesDao().fiadorRequerido(SolicitudCreditoActivity.planesStep.getStepData().getId())  < 1){
            markAsCompleted(true);
            System.out.println("NO REQUIERE FIADOR");
            spinner_fiadores.setEnabled(false);
            tieneNegocio.setEnabled(false);
        }else{
            spinner_fiadores.setEnabled(true);
            tieneNegocio.setEnabled(true);
        }*/

        final int id = ((Cliente)SolicitudCreditoActivity.infoStep.getStepData().get("cliente")).getId_cliente();

        fiadoresList = AppDatabase.getInstance(context).getClienteDao().getAll_notId(id);

        fiadores = new String[fiadoresList.size()];

        for(Cliente c: fiadoresList){
            fiadores[fiadoresList.indexOf(c)] = c.getNombre();
        }
        spinner_fiadores.setItems(fiadores);

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
}
