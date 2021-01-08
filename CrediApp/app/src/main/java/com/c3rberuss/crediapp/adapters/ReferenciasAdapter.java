package com.c3rberuss.crediapp.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.entities.Referencia;
import com.c3rberuss.crediapp.utils.Functions;

import java.util.ArrayList;
import java.util.List;

public class ReferenciasAdapter extends RecyclerView.Adapter<ReferenciasAdapter.ReferenciaViewHolder> {

   public List<Referencia> referencias =  new ArrayList<>();
   private View.OnClickListener onClickListener;
   private int mode = 0;

    public ReferenciasAdapter(int mode) {
        this.mode = mode;
    }

    @NonNull
    @Override
    public ReferenciaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_referencia_layout, parent, false);
        return new ReferenciaViewHolder(view);

    }

    @Override
    public void onBindViewHolder(@NonNull ReferenciaViewHolder holder, int position) {

        final Referencia ref = referencias.get(position);

        final String num = Functions.intToString2Digits(position+1)+" - ";

        holder.nombre.setText(ref.getNombre());
        holder.numero.setText(num);

        if(mode == 0){
            holder.eliminar.setOnClickListener(v->{
                notifyItemRemoved(position);
                referencias.remove(ref);
            });
        }else{
            holder.eliminar.setVisibility(View.GONE);
        }

    }

    @Override
    public int getItemCount() {
        return this.referencias.size();
    }

    public void addReferencia(Referencia ref){
        this.referencias.add(ref);
        notifyDataSetChanged();
    }

    public void swapData(List<Referencia> referencias_){
        this.referencias.clear();
        this.referencias.addAll(referencias_);
        notifyDataSetChanged();
    }

    public void setOnClickListener(View.OnClickListener listener){
        this.onClickListener = listener;
    }

    class ReferenciaViewHolder extends RecyclerView.ViewHolder{

        TextView numero;
        TextView nombre;
        ImageButton eliminar;

        public ReferenciaViewHolder(@NonNull View itemView) {
            super(itemView);

            itemView.setOnClickListener(onClickListener);
            numero = itemView.findViewById(R.id.lblNumeroRef);
            nombre = itemView.findViewById(R.id.lblNombreRef);
            eliminar = itemView.findViewById(R.id.btnEliminarRef);
        }
    }

}
