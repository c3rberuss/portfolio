package com.c3rberuss.crediapp.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.entities.Cobro;
import com.c3rberuss.crediapp.utils.CobroFilter;
import com.c3rberuss.crediapp.utils.Functions;

import java.util.List;

public class CobroAdapter extends RecyclerView.Adapter<CobroAdapter.CobroViewHolder> implements Filterable {

    public List<Cobro> clientes, filterList;
    private CobroFilter filter;

    public CobroAdapter(List<Cobro> clientes) {
        this.clientes = clientes;
        this.filterList = clientes;
    }

    @NonNull
    @Override
    public CobroViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.cliente_item, parent, false);
        return new CobroViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CobroViewHolder holder, int position) {

        final Cobro cliente = clientes.get(position);
        holder.nombre.setText(cliente.getNombre());
        final String num = Functions.intToString2Digits(position+1) + " - ";
        holder.numero.setText(num);

    }

    @Override
    public int getItemCount() {
        return (this.clientes == null) ? 0 : this.clientes.size();
    }

    public void swapData(List<Cobro> clientes_){
        this.clientes.clear();
        this.clientes.addAll(clientes_);
        notifyDataSetChanged();
    }

    @Override
    public Filter getFilter() {
        if(filter==null)
        {
            filter=new CobroFilter(this, filterList);
        }
        return filter;
    }

    class CobroViewHolder extends RecyclerView.ViewHolder{

        TextView numero;
        TextView nombre;

        public CobroViewHolder(@NonNull View itemView) {
            super(itemView);

            this.numero = itemView.findViewById(R.id.lblNumeroCliente);
            this.nombre = itemView.findViewById(R.id.lblNombreCliente);
        }
    }

}