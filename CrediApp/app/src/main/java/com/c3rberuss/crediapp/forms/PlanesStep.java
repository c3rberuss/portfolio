package com.c3rberuss.crediapp.forms;

import android.app.Dialog;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.SolicitudCreditoActivity;
import com.c3rberuss.crediapp.adapters.PlanesAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Frecuencia;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito;

import java.util.ArrayList;
import java.util.List;

import ernestoyaquello.com.verticalstepperform.Step;

public class PlanesStep extends Step<Plan> {

    private Context context;
    private List<PlanRequisito> planes = new ArrayList<>();
    private PlanesAdapter adapter;
    private LayoutInflater inflater;
    private TextView plan_select;
    private int pos = 0;
    private int maxPos;

    public PlanesStep(String title, Context context) {
        super(title);
        this.context = context;
        this.inflater = LayoutInflater.from(this.context);

        this.maxPos = planes.size()-1;
    }

    protected PlanesStep(String title, String subtitle, Context context) {
        super(title, subtitle);
        this.context = context;
        this.inflater = LayoutInflater.from(this.context);
    }

    protected PlanesStep(String title, String subtitle, String nextButtonText, Context context) {
        super(title, subtitle, nextButtonText);
        this.context = context;
        this.inflater = LayoutInflater.from(this.context);
    }

    @Override
    public Plan getStepData() {
        return adapter.plan_seleccionado;
    }

    @Override
    public String getStepDataAsHumanReadableString() {
        return null;
    }

    @Override
    public void restoreStepData(Plan data) {
        adapter.plan_seleccionado = data;
    }

    @Override
    protected IsDataValid isStepDataValid(Plan stepData) {

        if(stepData == null){
            return new IsDataValid(false);
        }

        return new IsDataValid(true);

    }

    @Override
    protected View createStepContentLayout() {

        //LayoutInflater inflater = LayoutInflater.from(this.context);
        View view = inflater.inflate(R.layout.planes_layout_step, null, false);

        this.plan_select = view.findViewById(R.id.lblPlanSeleccionado);

        //final RecyclerView recyclerView = view.findViewById(R.id.listaPlanes);
        //recyclerView.setLayoutManager(new LinearLayoutManager(this.context));
        adapter = new PlanesAdapter(this.planes, context);
        //recyclerView.setAdapter(adapter);

        view.findViewById(R.id.btnVerPlanes).setOnClickListener(v->{
            //planesDialog(this.context, (ViewGroup) view.findViewById(android.R.id.content)).show();
            //SolicitudCreditoActivity.planesDialog(adapter).show();
            planesDialog();
        });

        return view;
    }

    @Override
    protected void onStepOpened(boolean animated) {

        planes.clear();
        planes.addAll(

        AppDatabase.getInstance(context).getPlanesDao()
                .getAllByRange(((Frecuencia)SolicitudCreditoActivity.infoStep.getStepData().get("frecuencia")).getId(),
                        Double.parseDouble((String) SolicitudCreditoActivity.infoStep.getStepData().get("monto"))));

    }

    @Override
    protected void onStepClosed(boolean animated) {
        if(adapter.plan_seleccionado != null){
            System.out.println(adapter.plan_seleccionado.getNombre());
        }
    }

    @Override
    protected void onStepMarkedAsCompleted(boolean animated) {
        if(adapter.plan_seleccionado != null){
            System.out.println(adapter.plan_seleccionado.getNombre());
        }
    }

    @Override
    protected void onStepMarkedAsUncompleted(boolean animated) {
    }

    private void planesDialog(){
        final Dialog dialog = new Dialog(context);
        dialog.setContentView(R.layout.lista_planes_layout);
        Window window = dialog.getWindow();
        window.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        dialog.setCancelable(false);

        final RecyclerView recyclerView = dialog.findViewById(R.id.l_p);
        recyclerView.setAdapter(adapter);

/*        final LinearLayoutManager linearLayoutManager = new LinearLayoutManager(context){
            @Override
            public boolean canScrollHorizontally() {
                return  true;
            }
        };

        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);

        recyclerView.setLayoutManager(linearLayoutManager);*/

        final Button btnAceptar = dialog.findViewById(R.id.btnAceptar);
        final Button btnCancelar = dialog.findViewById(R.id.btnCancelar);

        final ImageButton btnAnterior = dialog.findViewById(R.id.btnAnterior);
        final ImageButton btnSiguiente = dialog.findViewById(R.id.btnSiguiente);



        final TextView n_plan = dialog.findViewById(R.id.lblNplanDisplay);

        n_plan.setText(String.format("Plan %o/%o", pos+1, this.planes.size()));

        btnAnterior.setEnabled(false);


        if(adapter.plan_seleccionado != null){

            final int pos_ = adapter.pos_list;

            if(pos_ == 0){
                btnAnterior.setEnabled(false);
                btnSiguiente.setEnabled(true);
            }else if(pos_ > 0 && pos_ < this.planes.size()-1){
                btnAnterior.setEnabled(true);
                btnSiguiente.setEnabled(true);
            }else if(pos_ == this.planes.size()-1){
                btnAnterior.setEnabled(true);
                btnSiguiente.setEnabled(false);
            }

            recyclerView.scrollToPosition(pos_);
        }

        btnAnterior.setOnClickListener(v->{
            if(pos == 0){
                btnAnterior.setEnabled(false);
                btnSiguiente.setEnabled(true);
            }

            if(pos > 0){
                pos--;
                recyclerView.scrollToPosition(pos);
                n_plan.setText(String.format("Plan %o/%o", pos+1, this.planes.size()));
                btnSiguiente.setEnabled(true);
                //btnAnterior.setVisibility(View.VISIBLE);
            }
        });

        btnSiguiente.setOnClickListener(v->{

            if(pos == this.planes.size()-1){
                btnSiguiente.setEnabled(false);
                btnAnterior.setEnabled(true);
            }

            if(pos < this.planes.size()-1){
                pos++;
                recyclerView.scrollToPosition(pos);
                btnAnterior.setEnabled(true);

                n_plan.setText(String.format("Plan %o/%o", pos+1, this.planes.size()));
            }

        });


        btnAceptar.setOnClickListener(v->{

            if(adapter.plan_seleccionado == null){
                plan_select.setText("---");
                markAsUncompleted("", true);
            }else{
                plan_select.setText(adapter.plan_seleccionado.getNombre());
                markAsCompleted(true);
            }

            dialog.dismiss();

        });

        btnCancelar.setOnClickListener(v->{
            dialog.dismiss();
        });

        dialog.show();
    }


}
