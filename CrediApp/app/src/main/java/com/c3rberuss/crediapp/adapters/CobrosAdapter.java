package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.entities.CobroProcesado;
import com.c3rberuss.crediapp.utils.Functions;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;
import butterknife.BindView;
import butterknife.ButterKnife;

public class CobrosAdapter extends RecyclerView.Adapter<CobrosAdapter.ViewHolder> {

    List<CobroProcesado> cobros;
    Context mCtx;

    public CobrosAdapter(Context context, List<CobroProcesado> cobros) {
        this.cobros = cobros;
        mCtx = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.cobro_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        final CobroProcesado tmp = cobros.get(position);

        holder.lblCuota.setText(tmp.getCuota());
        holder.lblNombreCliente.setText(tmp.getCliente());
        holder.lblEstado.setText(tmp.isSincronizado() ? "SINCRONIZADO" : "NO SINCRONIZADO");
        holder.lblMonto.setText(String.format("$%s", Functions.round2decimals(tmp.getMonto() + tmp.getMora())));
        holder.lblFecha.setText(Functions.fechaDMY(tmp.getFecha()));
        holder.lblHora.setText(tmp.getHora());
        holder.lblTipo.setText(switchTipoCobro(tmp));

        if (!tmp.isSincronizado()) {

            holder.card.setCardBackgroundColor(mCtx.getResources().getColor(R.color.mora));
            holder.textView38.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView39.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView40.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView42.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView44.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblMonto.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView46.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblTipo.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblHora.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblFecha.setTextColor(mCtx.getResources().getColor(R.color.white));

            holder.lblEstado.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblNombreCliente.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblCuota.setTextColor(mCtx.getResources().getColor(R.color.white));

        } else {

            holder.card.setCardBackgroundColor(mCtx.getResources().getColor(R.color.verde));
            holder.textView38.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView39.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView40.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView42.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView44.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblMonto.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView46.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblTipo.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblHora.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblFecha.setTextColor(mCtx.getResources().getColor(R.color.white));

            holder.lblEstado.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblNombreCliente.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblCuota.setTextColor(mCtx.getResources().getColor(R.color.white));

        }
    }

    private String switchTipoCobro(CobroProcesado cobro){
        String tipo = "";

        System.out.println(cobro.isAbono());
        System.out.println(cobro.isPago_mora());
        System.out.println(cobro.isSoloMora());

        if(cobro.isAbono()){
            tipo = "ABONO";
        }else if(cobro.isPago_mora() || cobro.isSoloMora()){
            tipo = "MORA";
        }else{
            tipo = "PAGO";
        }

        return tipo;
    }

    @Override
    public int getItemCount() {
        return cobros.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.textView46)
        TextView textView46;
        @BindView(R.id.textView40)
        TextView textView40;
        @BindView(R.id.textView42)
        TextView textView42;
        @BindView(R.id.textView38)
        TextView textView38;
        @BindView(R.id.textView39)
        TextView textView39;
        @BindView(R.id.textView44)
        TextView textView44;
        @BindView(R.id.card)
        CardView card;

        @BindView(R.id.lblNombreCliente)
        TextView lblNombreCliente;
        @BindView(R.id.lblMonto)
        TextView lblMonto;
        @BindView(R.id.lblCuota)
        TextView lblCuota;
        @BindView(R.id.lblTipo)
        TextView lblTipo;
        @BindView(R.id.lblFecha)
        TextView lblFecha;
        @BindView(R.id.lblHora)
        TextView lblHora;
        @BindView(R.id.lblEstado)
        TextView lblEstado;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

}
