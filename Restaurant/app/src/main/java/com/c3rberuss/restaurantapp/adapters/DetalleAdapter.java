package com.c3rberuss.restaurantapp.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.dao.PedidoDao;
import com.c3rberuss.restaurantapp.db.dao.PedidoDetalleDao;
import com.c3rberuss.restaurantapp.entities.DetallePlatillo;
import com.c3rberuss.restaurantapp.entities.Pedido;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.squareup.picasso.Picasso;

import java.util.List;

public class DetalleAdapter extends RecyclerView.Adapter<DetalleAdapter.ViewHolder> {


    public List<DetallePlatillo> detalles;
    PedidoDao pedidoDao;
    PedidoDetalleDao pedidoDetalleDao;

    private View.OnClickListener onClickListener;

    public DetalleAdapter(List<DetallePlatillo> detalles) {
        this.detalles = detalles;
        pedidoDao = MainActivity.database.getPedidoDao();
        pedidoDetalleDao = MainActivity.database.getPedidoDetalleDao();
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_detalle_pedido, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {

        final DetallePlatillo tmp = detalles.get(position);
        holder.nombre.setText(tmp.getNombre());

        final String qty = String.valueOf(tmp.getCantidad())+"x";
        holder.cantidad.setText(qty);

        final String sub = "$"+String.valueOf(tmp.getSubtotal());
        holder.subtotal.setText(sub);

//        Picasso.get().load(WebService.SERVER_URL+tmp.getImagen())
//                .error(R.drawable.food)
//                .centerCrop()
//                .fit()
//                .into(holder.imagen);

        holder.eliminar.setOnClickListener(v->{
            notifyItemRemoved(position);

            final Pedido pedido = pedidoDao.obtenerPedidoActivo();
            pedido.setTotal(pedido.getTotal() - tmp.getSubtotal());
            pedidoDetalleDao.delete(pedidoDetalleDao.getDetalle(tmp.getId_platillo(), pedido.getId()));

            MainActivity.updateHotCount(false);
            detalles.remove(tmp);

            if(detalles.size() < 1){
                pedidoDao.delete(pedido);
            }

        });
    }

    public void setOnClickListener(View.OnClickListener onClickListener) {
        this.onClickListener = onClickListener;
    }

    public void swapData(List<DetallePlatillo> detalles){
        this.detalles = detalles;
        notifyDataSetChanged();
    }

    @Override
    public int getItemCount() {
        if(detalles != null){
            return detalles.size();
        }

        return 0;
    }

    class ViewHolder extends RecyclerView.ViewHolder{

        TextView cantidad, nombre, subtotal;
        ImageView imagen;
        ImageButton eliminar;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            cantidad = itemView.findViewById(R.id.lblCantidadDetalle);
            nombre = itemView.findViewById(R.id.lblNombreDetalle);
            subtotal = itemView.findViewById(R.id.lblSubTotalDetalle);
            //imagen = itemView.findViewById(R.id.img_detalle);
            eliminar = itemView.findViewById(R.id.btnEliminarItem);

            itemView.setOnClickListener(onClickListener);
        }
    }

}
