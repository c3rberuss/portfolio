package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.DetalleClienteActivity;
import com.c3rberuss.crediapp.entities.Cliente;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.ClientesFilter;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.util.List;

public class ClientesAdapter extends RecyclerView.Adapter<ClientesAdapter.ClienteViewHolder> implements Filterable {

    public List<Cliente> clientes, filterList;
    private ClientesFilter filter;
    private Context context;

    public ClientesAdapter(List<Cliente> clientes, Context context) {
        this.clientes = clientes;
        this.filterList = clientes;
        this.context = context;
    }

    @NonNull
    @Override
    public ClienteViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.cliente_item, parent, false);
        return new ClienteViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ClienteViewHolder holder, int position) {

        final Cliente cliente = clientes.get(position);

        holder.nombre.setText(cliente.getNombre());
        holder.telefono.setText(cliente.getTelefono());
        holder.dui.setText(cliente.getDui());
        holder.nit.setText(cliente.getNit());
        holder.direccion.setText(cliente.getDireccion());

        if(!cliente.isRevisado()){

            final int blanco = context.getResources().getColor(R.color.white);

            holder.card.setCardBackgroundColor(context.getResources().getColor(R.color.mora));
            holder.nombre.setTextColor(blanco);
            holder.telefono.setTextColor(blanco);
            holder.dui.setTextColor(blanco);
            holder.nit.setTextColor(blanco);
            holder.direccion.setTextColor(blanco);

            holder.l19.setBackgroundColor(blanco);
            holder.l20.setTextColor(blanco);
            holder.l21.setTextColor(blanco);
            holder.l22.setTextColor(blanco);
            holder.l23.setTextColor(blanco);

        }else{
            final int negro = context.getResources().getColor(R.color.black);

            holder.card.setCardBackgroundColor(context.getResources().getColor(R.color.white));
            holder.nombre.setTextColor(negro);
            holder.telefono.setTextColor(negro);
            holder.dui.setTextColor(negro);
            holder.nit.setTextColor(negro);
            holder.direccion.setTextColor(negro);

            holder.l19.setBackgroundColor(negro);
            holder.l20.setTextColor(negro);
            holder.l21.setTextColor(negro);
            holder.l22.setTextColor(negro);
            holder.l23.setTextColor(negro);
        }

        if(cliente.isSincronizado()){
            Picasso.get().load(WebService.ROOT_URL + cliente.getImagen())
                    .centerCrop()
                    .fit()
                    .placeholder(R.drawable.nodisp)
                    .error(R.drawable.nodisp)
                    .into(holder.imagen);
        }else{

            String path = cliente.getImagen() == null ? "" : cliente.getImagen();

            Picasso.get().load(new File(path))
                    .centerCrop()
                    .fit()
                    .placeholder(R.drawable.nodisp)
                    .error(R.drawable.nodisp)
                    .into(holder.imagen);
        }
    }

    @Override
    public int getItemCount() {
       return (this.clientes == null) ? 0 : this.clientes.size();
    }

    public void swapData(List<Cliente> clientes_){
        this.clientes.clear();
        this.clientes.addAll(clientes_);
        notifyDataSetChanged();
    }

    @Override
    public Filter getFilter() {
        if(filter==null)
        {
            filter=new ClientesFilter(this, filterList);
        }
        return filter;
    }

    class ClienteViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        TextView dui;
        TextView nit;
        TextView direccion;
        TextView telefono;
        ImageView imagen;
        TextView nombre;
        CardView card;

        TextView l20, l21, l22, l23;
        View l19;

        public ClienteViewHolder(@NonNull View itemView) {
            super(itemView);

            this.dui = itemView.findViewById(R.id.lblDuiCliente);
            this.nombre = itemView.findViewById(R.id.lblNombreCliente);
            this.nit = itemView.findViewById(R.id.lblNitCliente);
            this.direccion = itemView.findViewById(R.id.lblDireccionCliente);
            this.telefono = itemView.findViewById(R.id.lblTelefonoCliente);
            this.imagen = itemView.findViewById(R.id.imagenCliente);
            this.card = itemView.findViewById(R.id.card_cliente);

            l19 = itemView.findViewById(R.id.l19);
            l20 = itemView.findViewById(R.id.l20);
            l21 = itemView.findViewById(R.id.l21);
            l22 = itemView.findViewById(R.id.l22);
            l23 = itemView.findViewById(R.id.l23);

            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            final Intent intent = new Intent(context, DetalleClienteActivity.class);
            intent.putExtra("id_cliente", clientes.get(getAdapterPosition()).getId_cliente());
            context.startActivity(intent);
        }
    }

}
