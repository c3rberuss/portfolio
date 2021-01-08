package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.PrestamoDetalleActivity;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.PrestamoFilter;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class PrestamoAdapter extends RecyclerView.Adapter<PrestamoAdapter.PrestamoViewHolder> implements Filterable {
    private Context mCtx;
    public List<Prestamo> clientes, filterList;
    private PrestamoFilter filter;
    private View.OnClickListener onClickListener;

    public PrestamoAdapter(Context mCtx, List<Prestamo> clientes) {
        this.mCtx = mCtx;
        this.clientes = clientes;
        this.filterList = clientes;
    }

    @NonNull
    @Override
    public PrestamoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(mCtx).inflate(R.layout.prestamo_item_2, parent, false);
        return new PrestamoViewHolder(view);

    }

    @Override
    public void onBindViewHolder(@NonNull PrestamoViewHolder holder, int position) {
        final Prestamo cliente = Functions.prestamoConMora(mCtx, clientes.get(position));

        String cliente_nombre = cliente.getNombre(); //+ " * Monto:  $" + Functions.round2decimals(cliente.getFinaal()) + " - Saldo:  $" + Functions.round2decimals(cliente.getSaldo());
        holder.lblNombCliente.setText(cliente_nombre);
        final String num = Functions.intToString2Digits(position + 1) + " - ";
        holder.lblNumeroCliente.setText(num);

        holder.lblSaldo.setText(String.format("$%s", Functions.round2decimals(cliente.getSaldo())));
        holder.lblMonto.setText(String.format("$%s", Functions.round2decimals(cliente.getFinaal())));
        holder.lblMora.setText(String.format("$%s", Functions.round2decimals(cliente.getMoraTotal())));
    }

    @Override
    public int getItemCount() {
        return (this.clientes == null) ? 0 : this.clientes.size();
    }

    public void swapData(List<Prestamo> prestamos) {
        this.clientes.clear();
        this.filterList.clear();
        this.clientes.addAll(prestamos);
        this.filterList.addAll(prestamos);
        notifyDataSetChanged();
    }

    public void insertNews(List<Prestamo> prestamos) {
        this.clientes.addAll(prestamos);
        this.filterList.addAll(prestamos);
        Log.e("CALL", String.valueOf(prestamos.size()));
    }

    public void setOnClickListener(View.OnClickListener onClickListener) {
        this.onClickListener = onClickListener;
    }

    @Override
    public Filter getFilter() {
        if (filter == null) {
            filter = new PrestamoFilter(this, filterList);
        }
        return filter;
    }

    class PrestamoViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {


        @BindView(R.id.lblMonto)
        TextView lblMonto;
        @BindView(R.id.lblSaldo)
        TextView lblSaldo;
        @BindView(R.id.lblMora)
        TextView lblMora;
        @BindView(R.id.lblNumeroCliente)
        TextView lblNumeroCliente;
        @BindView(R.id.lblNombCliente)
        TextView lblNombCliente;

        public PrestamoViewHolder(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
            itemView.setOnClickListener(onClickListener);
        }

        @Override
        public void onClick(View view) {
            final Prestamo prestamo = clientes.get(getAdapterPosition());
            String nombrecliente = prestamo.getNombre();
            String cliente_monto = " * Monto:  $" + prestamo.getFinaal() + " - Saldo:  $" + prestamo.getSaldo();
            int id_prestamo = prestamo.getId_prestamo();
            //  Toast.makeText(mCtx, "Prestamo Seleccionado"+nombrecliente, Toast.LENGTH_LONG).show();
            Intent intent = new Intent(mCtx, PrestamoDetalleActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            intent.putExtra("id_prestamo", id_prestamo);
            intent.putExtra("nombre", nombrecliente);
            intent.putExtra("cliente_monto", cliente_monto);
            intent.putExtra("ultimo_pago", prestamo.getProxima_mora());
            mCtx.startActivity(intent);

        }
    }

}