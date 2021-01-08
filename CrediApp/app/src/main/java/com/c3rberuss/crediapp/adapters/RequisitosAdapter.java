package com.c3rberuss.crediapp.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.entities.Requisito;

import java.util.List;

public class RequisitosAdapter extends RecyclerView.Adapter<RequisitosAdapter.RequisitoViewHolder> {


    List<Requisito> requisitos;

    public RequisitosAdapter(List<Requisito> requisitos) {
        this.requisitos = requisitos;
    }

    @NonNull
    @Override
    public RequisitoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.requisito_item, parent, false);
        return new RequisitoViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RequisitoViewHolder holder, int position) {

        final Requisito requisito = requisitos.get(position);

        final String text = requisito.getNombre() + "\n -> "+requisito.getCantidad();
        holder.nombre.setText(text);

    }

    public void swapData(List<Requisito> requisitos){
        this.requisitos.clear();
        this.requisitos.addAll(requisitos);
        notifyDataSetChanged();
    }

    @Override
    public int getItemCount() {
        return this.requisitos.size();
    }

    class RequisitoViewHolder extends RecyclerView.ViewHolder{

        TextView nombre;

        public RequisitoViewHolder(@NonNull View itemView) {
            super(itemView);
            nombre = itemView.findViewById(R.id.lblNombreRequisito);
        }
    }

}
