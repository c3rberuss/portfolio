package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.SolicitudCredito;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.SolicitudesFilter;

import java.util.List;

import butterknife.ButterKnife;

public class SolicitudAdapter extends RecyclerView.Adapter<SolicitudAdapter.PrestamoViewHolder> implements Filterable {
    private Context mCtx;
    public List<SolicitudCredito> solicitudCreditos, filterList;
    private SolicitudesFilter filter;
    private AppDatabase db;

    public SolicitudAdapter(Context mCtx, List<SolicitudCredito> solicitudes) {
        this.mCtx = mCtx;
        this.solicitudCreditos = solicitudes;
        this.filterList = solicitudes;
        db = AppDatabase.getInstance(mCtx);
    }
    @NonNull
    @Override
    public PrestamoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(mCtx).inflate(R.layout.solicitud_item, parent, false);
        return new PrestamoViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PrestamoViewHolder holder, int position) {
        final SolicitudCredito tmp = solicitudCreditos.get(position);

        final String nombre_cliente = AppDatabase.getInstance(mCtx).getClienteDao().getNombre(tmp.getId_cliente());

        String cliente_monto= nombre_cliente+" * Monto:  $"+tmp.getMonto();

        if(tmp.getRefinanciamiento() > 0){
            cliente_monto += "   *REFINANCIAMIENTO* ";
        }else{
            cliente_monto += "   *SOLICITUD* ";
        }

        holder.nombre.setText(cliente_monto);
        final String num = Functions.intToString2Digits(position+1) + " - ";
        holder.numero.setText(num);

        if(!tmp.isSincronizada()){
            holder.eliminar.setVisibility(View.VISIBLE);
            holder.eliminar.setOnClickListener(v->{

                if(tmp.isTiene_fiador()){
                    db.getFiadorDao().delete(tmp.getFiador());
                }

                db.getSolicitudDetalleDao().deleteAllBySolicitud(tmp.getId_solicitud());
                db.getGarantiaDao().deleteAllBySolicitud(tmp.getId_solicitud());
                db.getSolicitudDao().delete(tmp);
                notifyItemRemoved(position);

                solicitudCreditos.remove(position);
            });
        }else{
            holder.eliminar.setVisibility(View.GONE);
        }
    }

    @Override
    public int getItemCount() {
        return (this.solicitudCreditos == null) ? 0 : this.solicitudCreditos.size();
    }

    public void swapData(List<SolicitudCredito> prestamos){
        this.solicitudCreditos = prestamos;
        this.filterList = prestamos;
        notifyDataSetChanged();
    }

    @Override
    public Filter getFilter() {
        if(filter==null)
        {
            filter=new SolicitudesFilter(this, filterList, mCtx);
        }
        return filter;
    }

    class PrestamoViewHolder extends RecyclerView.ViewHolder  implements View.OnClickListener {

       /* @BindView(R.id.lblNumCliente) */TextView numero;
       /* @BindView(R.id.lblNombreCliente) */TextView nombre;
       /* @BindView(R.id.btnEliminarSolicitud)*/
        ImageButton eliminar;

        public PrestamoViewHolder(@NonNull View itemView) {
            super(itemView);

            ButterKnife.bind(this, itemView);

            this.numero = itemView.findViewById(R.id.lblNumeroCliente);
            this.nombre = itemView.findViewById(R.id.lblNombreCliente);
            eliminar = itemView.findViewById(R.id.btnEliminarSolicitud);

            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
           /* Prestamo prestamo = clientes.get(getAdapterPosition());
            String nombrecliente= prestamo.getNombre();
            String cliente_monto= " * Monto:  $"+prestamo.getMonto()+" - Saldo:  $"+prestamo.getSaldo();
             int id_prestamo=prestamo.getId_prestamo();
          //  Toast.makeText(mCtx, "Prestamo Seleccionado"+nombrecliente, Toast.LENGTH_LONG).show();
            Intent intent = new Intent(mCtx, PrestamoDetalleActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
            intent.putExtra("id_prestamo", id_prestamo);
            intent.putExtra("nombre", nombrecliente);
            intent.putExtra("cliente_monto", cliente_monto);
            mCtx.startActivity(intent);*/

        }
    }

}