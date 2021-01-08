package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Mora;
import com.c3rberuss.crediapp.entities.Prestamo;
import com.c3rberuss.crediapp.entities.PrestamoDetalle;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.PrestamoDetalleFilter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;
import butterknife.BindView;
import butterknife.ButterKnife;

public class PrestamoDetalleAdapter extends RecyclerView.Adapter<PrestamoDetalleAdapter.PrestamoDetalleViewHolder> implements Filterable {

    private Context mCtx;
    public List<PrestamoDetalle> clientes, filterList;
    private PrestamoDetalleFilter filter;
    private int seleccionados = 0;
    private Prestamo prestamo;
    private int mode = 0;

    public PrestamoDetalleAdapter(Context mCtx, List<PrestamoDetalle> clientes, Prestamo prestamo, int mode) {
        this.mCtx = mCtx;
        this.clientes = clientes;
        this.filterList = clientes;
        this.prestamo = prestamo;
        this.mode = mode;
    }

    @NonNull
    @Override
    public PrestamoDetalleViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mCtx).inflate(R.layout.detalle_prestamo_item, parent, false);
        return new PrestamoDetalleViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PrestamoDetalleViewHolder holder, int position) {

        PrestamoDetalle cliente = clientes.get(position);

        if (mode == 0) {
            if (prestamo != null && seleccionados > 0) {
                final Mora mora = AppDatabase.getInstance(mCtx)
                        .prestamoDao().getDatosMoraPrestamo(prestamo.getMonto(), prestamo.getFrecuencia());

                if (position == 0) {
                    cliente = Functions.tieneMoraNew(clientes.get(position), mora, prestamo.getProxima_mora());
                }

                if (cliente.getMonto() + cliente.getMora() - cliente.getAbono() == 0) {
                    notifyItemRemoved(position);
                    clientes.remove(position);
                }
            }
        }

        holder.lblCorrelativo.setText(String.format("CUOTA %s", cliente.getCorrelativo()));
        holder.lblMonto.setText(String.format("$%s", Functions.round2decimals(cliente.getMonto())));
        holder.lblVence.setText(Functions.fechaDMY(cliente.getFecha_vence()));

        final double abono = cliente.getAbono(); //+ Math.min(cliente.getAbono(), cliente.getMonto());

        holder.lblAbono.setText(String.format("$%s", Functions.round2decimals(abono)));

        final double saldo = cliente.getMonto() - cliente.getAbono();
        holder.lblSaldo.setText(String.format("$%s", Functions.round2decimals(saldo > 0 ? saldo : 0)));

        final String num = Functions.intToString2Digits(position + 1) + " - ";

        holder.lblNumeroCliente.setText(num);


        if (position < seleccionados && cliente.isTiene_mora()) {

            holder.cardItem.setCardBackgroundColor(mCtx.getResources().getColor(R.color.mora));
            holder.lblCorrelativo.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblNumeroCliente.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblVence.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblMonto.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView20.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView12.setTextColor(mCtx.getResources().getColor(R.color.white));

            holder.lblSaldo.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.lblAbono.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView28.setTextColor(mCtx.getResources().getColor(R.color.white));
            holder.textView22.setTextColor(mCtx.getResources().getColor(R.color.white));

        } else {

            if (position < seleccionados) {
                holder.cardItem.setCardBackgroundColor(mCtx.getResources().getColor(R.color.seleccionado));
            } else {
                holder.cardItem.setCardBackgroundColor(mCtx.getResources().getColor(R.color.white));
            }

            holder.lblCorrelativo.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.lblNumeroCliente.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.lblVence.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.lblMonto.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.textView20.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.textView12.setTextColor(mCtx.getResources().getColor(R.color.black));

            holder.lblSaldo.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.lblAbono.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.textView28.setTextColor(mCtx.getResources().getColor(R.color.black));
            holder.textView22.setTextColor(mCtx.getResources().getColor(R.color.black));

        }
    }

    public void seleccionar(String qty) {
        seleccionados = Integer.valueOf(qty);
        System.out.println("SI SE LLAMO");
        //notifyItemRangeChanged(0, seleccionados-1);
        notifyDataSetChanged();
    }

    public void swapData(List<PrestamoDetalle> prestamoDetalles) {

        this.clientes.clear();
        this.clientes.addAll(prestamoDetalles);
        this.filterList.clear();
        this.filterList.addAll(prestamoDetalles);

        notifyDataSetChanged();

    }


    @Override
    public int getItemCount() {
        return (this.clientes == null) ? 0 : this.clientes.size();
    }


    @Override
    public Filter getFilter() {
        if (filter == null) {
            filter = new PrestamoDetalleFilter(this, filterList);
        }
        return filter;
    }

    class PrestamoDetalleViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.lblNumeroCliente)
        TextView lblNumeroCliente;
        @BindView(R.id.lblCorrelativo)
        TextView lblCorrelativo;
        @BindView(R.id.lblMonto)
        TextView lblMonto;
        @BindView(R.id.lblVence)
        TextView lblVence;
        @BindView(R.id.card_item)
        CardView cardItem;
        @BindView(R.id.textView20)
        TextView textView20;
        @BindView(R.id.textView12)
        TextView textView12;
        @BindView(R.id.lblAbono)
        TextView lblAbono;
        @BindView(R.id.lblSaldo)
        TextView lblSaldo;
        @BindView(R.id.textView28)
        TextView textView28;
        @BindView(R.id.textView22)
        TextView textView22;

        PrestamoDetalleViewHolder(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
            // itemView.setOnClickListener(this);
        }
    }

}