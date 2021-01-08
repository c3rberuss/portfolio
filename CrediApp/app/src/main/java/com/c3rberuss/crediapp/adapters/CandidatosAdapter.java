package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.RefinanciarActivity;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.utils.CandidatoFilter;
import com.c3rberuss.crediapp.utils.Functions;

import java.util.List;

public class CandidatosAdapter extends RecyclerView.Adapter<CandidatosAdapter.PrestamoViewHolder> implements Filterable {
    private Context mCtx;
    public List<Prestamo> clientes, filterList;
    private CandidatoFilter filter;

    public CandidatosAdapter(Context mCtx, List<Prestamo> clientes) {
        this.mCtx = mCtx;
        this.clientes = clientes;
        this.filterList = clientes;
    }
    @NonNull
    @Override
    public PrestamoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(mCtx).inflate(R.layout.prestamo_item, parent, false);
        return new PrestamoViewHolder(view);

    }

    @Override
    public void onBindViewHolder(@NonNull PrestamoViewHolder holder, int position) {
        Prestamo cliente = clientes.get(position);
        String cliente_monto= cliente.getNombre()+" * Monto:  $"+cliente.getFinaal()+" - Saldo:  $"+cliente.getSaldo();
        holder.nombre.setText(cliente_monto);
        final String num = Functions.intToString2Digits(position+1) + " - ";
        holder.numero.setText(num);
    }

    @Override
    public int getItemCount() {
        return (this.clientes == null) ? 0 : this.clientes.size();
    }

    public void swapData(List<Prestamo> prestamos){
        this.clientes = prestamos;
        this.filterList = prestamos;
        notifyDataSetChanged();
    }

    @Override
    public Filter getFilter() {
        if(filter==null)
        {
            filter=new CandidatoFilter(this, filterList);
        }
        return filter;
    }

    class PrestamoViewHolder extends RecyclerView.ViewHolder  implements View.OnClickListener {

        TextView numero;
        TextView nombre;

        public PrestamoViewHolder(@NonNull View itemView) {
            super(itemView);

            this.numero = itemView.findViewById(R.id.lblNumeroCliente);
            this.nombre = itemView.findViewById(R.id.lblNombreCliente);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            Prestamo prestamo = clientes.get(getAdapterPosition());
            String nombrecliente= prestamo.getNombre();
            String cliente_monto= " * Monto:  $"+prestamo.getFinaal()+" - Saldo:  $"+prestamo.getSaldo();
             int id_prestamo=prestamo.getId_prestamo();
          //  Toast.makeText(mCtx, "Prestamo Seleccionado"+nombrecliente, Toast.LENGTH_LONG).show();
            Intent intent = new Intent(mCtx, RefinanciarActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            intent.putExtra("id_prestamo", id_prestamo);
            mCtx.startActivity(intent);

        }
    }

}