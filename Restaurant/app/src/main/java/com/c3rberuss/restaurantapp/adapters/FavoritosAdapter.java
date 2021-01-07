package com.c3rberuss.restaurantapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.Platillo;
import com.c3rberuss.restaurantapp.entities.PlatilloFavorito;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.squareup.picasso.Picasso;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class FavoritosAdapter extends RecyclerView.Adapter<FavoritosAdapter.ViewHolderFav> {

    List<PlatilloFavorito> favoritos;
    Context context;
    PlatillosAdapter adapter;

    public FavoritosAdapter(List<PlatilloFavorito> favoritos, Context context, PlatillosAdapter adapter) {
        this.favoritos = favoritos;
        this.context = context;
        this.adapter = adapter;
    }

    @NonNull
    @Override
    public ViewHolderFav onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.favorito_item_layout, parent, false);
        return new ViewHolderFav(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolderFav holder, int position) {

        final PlatilloFavorito tmp = favoritos.get(position);

        System.out.println(tmp.getId_platillo());

        final Platillo platillo = AppDatabase.getInstance(context).getPlatilloDao().get_(tmp.getId_platillo());

        Picasso.get().load(WebService.SERVER_URL + platillo.getImagen())
                .fit()
                .centerCrop()
                .into(holder.imageCategoria);

        holder.lblNombreCategoria.setText(platillo.getNombre());
        holder.lblNplatillos.setText(String.format("Precio: $%s", String.valueOf(platillo.getPrecio())));

    }

    public void swapData(List<PlatilloFavorito> fav) {
        this.favoritos.clear();
        this.favoritos.addAll(fav);
        notifyDataSetChanged();
    }

    @Override
    public int getItemCount() {
        return favoritos != null ? favoritos.size() : 0;
    }

    class ViewHolderFav extends RecyclerView.ViewHolder {
        @BindView(R.id.image_categoria)
        ImageView imageCategoria;
        @BindView(R.id.lblNombreCategoria)
        TextView lblNombreCategoria;
        @BindView(R.id.lblNplatillos)
        TextView lblNplatillos;
        @BindView(R.id.btnQuitarFav)
        ImageButton btnQuitarFav;

        public ViewHolderFav(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);

        }

        @OnClick(R.id.btnQuitarFav)
        void onClick(){
            final PlatilloFavorito f = favoritos.get(getAdapterPosition());
           AppDatabase.getInstance(context).getPlatilloFavorito().update(false,  f.getId());
           notifyItemRemoved(getAdapterPosition());
           adapter.noFav(f.getId_platillo());
        }
    }
}
