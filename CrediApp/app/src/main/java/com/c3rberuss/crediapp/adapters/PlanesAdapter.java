package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Plan;
import com.c3rberuss.crediapp.entities.PlanRequisito;
import com.c3rberuss.crediapp.entities.Requisito;

import java.util.ArrayList;
import java.util.List;

public class PlanesAdapter extends RecyclerView.Adapter<PlanesAdapter.PlanViewHolder> {

    List<PlanRequisito> planes;
    Context context;
    CheckBox seleccionado;
    int id_plan = 0;
    public Plan plan_seleccionado;
    public int pos_plan = 0;
    public int pos_list = -1;
    private AppDatabase db;

    public PlanesAdapter(List<PlanRequisito> planes, Context context) {
        this.planes = planes;
        this.context = context;

        db = AppDatabase.getInstance(context);
    }

    @NonNull
    @Override
    public PlanViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.plan_item, parent, false);
        return new PlanViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PlanViewHolder holder, int position) {

        final Plan plan = this.planes.get(position).getPlan();
        final List<Requisito> requisitos = AppDatabase.getInstance(context).getPlanRequisitoDao().getRequisitos(plan.getId());

        //AppDatabase.getInstance(context).getPlanesDao();

        //Log.e("PLAN", plan.getNombre());
        //Log.e("REQUISITOS", String.valueOf(requisitos.size()));

        holder.nombre.setText(plan.getNombre());
        final String porcentaje = String.valueOf(plan.getPorcentaje())+"%";
        holder.porcentaje.setText(porcentaje);

        holder.frecuencia.setText(db.getFrecuenciaDao().getById(plan.getFrecuencia()).getNombre());
        final String min ="$"+String.valueOf(plan.getDesde());
        holder.minimo.setText(min);

        final String max = "$"+String.valueOf(plan.getHasta());
        holder.maximo.setText(max);

        if(pos_list == position){
            holder.check.setChecked(true);
            seleccionado = holder.check;
        }

        holder.check.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if(isChecked){

                if(seleccionado != null){
                    seleccionado.setChecked(false);
                    id_plan = 0;
                    plan_seleccionado = null;
                    pos_list = -1;
                }

                seleccionado = holder.check;
                id_plan = plan.getId();
                plan_seleccionado = plan;
                pos_list = position;
                notifyDataSetChanged();

            }else{
                seleccionado = null;
                plan_seleccionado = null;
                pos_list = -1;
            }
        });

        if(requisitos.size() > 0){
            holder.adapter.swapData(requisitos);
            //holder.requisitos.setVisibility(View.VISIBLE);

            String requisitos_ = "";

            System.out.println("REQUISITO SIZE: "+String.valueOf(requisitos.size()));
            for(Requisito r: requisitos){
                requisitos_ += "* "+r.getNombre()+" -> "+r.getCantidad()+"\n";
            }

            System.out.println(requisitos_);

            requisitos_  += "\n";
            holder.req.setText(requisitos_);

        }else{
            //holder.requisitos.setVisibility(View.GONE);
/*            holder.req.setVisibility(View.GONE);*/
        }

        final String mora = String.valueOf(plan.getMora())+"%";
        holder.mora.setText(mora);

        final String val_cont = "$"+String.valueOf(plan.getValor_contrato());
        holder.contrato.setText(val_cont);

    }

    @Override
    public int getItemCount() {
        return this.planes.size();
    }

    class PlanViewHolder extends RecyclerView.ViewHolder{

        TextView nombre;
        TextView porcentaje;
        TextView frecuencia;
        TextView minimo;
        TextView maximo;
        TextView mora;
        TextView contrato;
        CheckBox check;
        RecyclerView requisitos;
        RequisitosAdapter adapter;
        List<Requisito> requisitosList;
        TextView req;

        public PlanViewHolder(@NonNull View itemView) {
            super(itemView);

            nombre = itemView.findViewById(R.id.lblNombrePlanItem);
            porcentaje = itemView.findViewById(R.id.lblPorcentajeItem);
            frecuencia = itemView.findViewById(R.id.lblFrecuenciaItem);
            minimo = itemView.findViewById(R.id.lblMontoMinimoItem);
            maximo = itemView.findViewById(R.id.lblMontoMaximoItem);
            check = itemView.findViewById(R.id.check);
            requisitos = itemView.findViewById(R.id.lista_requisitos);
            contrato = itemView.findViewById(R.id.lblCostoContratoItem);
            mora = itemView.findViewById(R.id.lblMoraItem);

            requisitosList = new ArrayList<>();
            adapter = new RequisitosAdapter(requisitosList);
            requisitos.setAdapter(adapter);

            req = itemView.findViewById(R.id.listaRequisitos2);

        }
    }

}

