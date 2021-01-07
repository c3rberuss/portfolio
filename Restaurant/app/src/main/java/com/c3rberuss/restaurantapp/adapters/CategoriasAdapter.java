package com.c3rberuss.restaurantapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.entities.Categoria;
import com.c3rberuss.restaurantapp.entities.CategoriaPlatillos;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.squareup.picasso.Picasso;

import java.util.List;

public class CategoriasAdapter extends RecyclerView.Adapter<CategoriasAdapter.ViewHolder> {

    private List<CategoriaPlatillos> categorias;
    private Context context;
    private View.OnClickListener onClickListener;

    public CategoriasAdapter(List<CategoriaPlatillos> categorias, Context context) {
        this.categorias = categorias;
        this.context = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.categoria_item_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {

        final Categoria tmp = categorias.get(position).getCategoria();
        holder.nombre.setText(tmp.getNombre());

        final String number = String.valueOf(categorias.get(position).getPlatillos().size()) + " Items";
        holder.numero.setText(number);

        Picasso.get().load(WebService.SERVER_URL+tmp.getImage())
                .centerCrop()
                .fit()
                .error(R.drawable.food)
                .into(holder.image);
    }

    public void swapData(List<CategoriaPlatillos> categorias){
        this.categorias = categorias;
        notifyDataSetChanged();
    }

    public void setOnClickListener(View.OnClickListener listener){
        this.onClickListener = listener;
    }

    @Override
    public int getItemCount() {

        if(this.categorias != null){
            return categorias.size();
        }

        return 0;
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        TextView nombre;
        TextView numero;
        ImageView image;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            nombre = itemView.findViewById(R.id.lblNombreCategoria);
            numero = itemView.findViewById(R.id.lblNplatillos);
            image = itemView.findViewById(R.id.image_categoria);

            itemView.setOnClickListener(onClickListener);
        }
    }

    public List<CategoriaPlatillos> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<CategoriaPlatillos> categorias) {
        this.categorias = categorias;
    }
}
