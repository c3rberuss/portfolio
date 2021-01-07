package com.c3rberuss.restaurantapp.adapters;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.db.dao.FavoritosDao;
import com.c3rberuss.restaurantapp.db.dao.UsuarioDao;
import com.c3rberuss.restaurantapp.entities.Platillo;
import com.c3rberuss.restaurantapp.entities.PlatilloFavorito;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.c3rberuss.restaurantapp.providers.WebService;
import com.c3rberuss.restaurantapp.utils.PlatillosFilter;
import com.squareup.picasso.Picasso;

import java.util.List;

public class PlatillosAdapter extends RecyclerView.Adapter<PlatillosAdapter.ViewHolder> implements Filterable {


    public List<Platillo> platillos, filterList;
    private Context context;
    private View.OnClickListener onClickListener;
    private FavoritosDao favoritosDao;
    private UsuarioDao usuarioDao;
    private PlatillosFilter filter;
    private PlatilloFavorito favorito;

    public PlatillosAdapter(List<Platillo> platillos_, Context context) {
        this.platillos = platillos_;
        this.filterList = platillos_;
        this.context = context;

        favoritosDao = AppDatabase.getInstance(context).getPlatilloFavorito();
        usuarioDao = AppDatabase.getInstance(context).getUsuarioDao();
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.platillo_item_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {

        final Platillo tmp = platillos.get(position);

        holder.nombre.setText(tmp.getNombre());
        holder.descripcion.setText(tmp.getDescripcion());

        final String precio = "$"+String.valueOf(tmp.getPrecio());
        holder.precio.setText(precio);

        Picasso.get().load(WebService.SERVER_URL+tmp.getImagen())
                .error(R.drawable.food)
                .centerCrop()
                .fit()
                .into(holder.imagen);


        final Usuario usuario = usuarioDao.getUsuarioActivo();

        if(usuario ==  null){
            holder.favorito.setEnabled(false);
        }else{

            holder.platilloFavorito = favoritosDao.get(usuario.getId(), tmp.getId_platillo());

            if(holder.platilloFavorito != null){
                holder.favorito.setChecked(holder.platilloFavorito.isFav());
            }else{
                holder.platilloFavorito = new PlatilloFavorito();
                holder.platilloFavorito.setId_usuario(usuario.getId());
                holder.platilloFavorito.setId_platillo(tmp.getId_platillo());
                holder.platilloFavorito.setId_categoria(tmp.getId_categoria());
                favoritosDao.addFavorite(holder.platilloFavorito);
                holder.platilloFavorito = favoritosDao.get(usuario.getId(), tmp.getId_platillo());
            }

        }

        holder.favorito.setOnCheckedChangeListener((v, checked)-> {
            favoritosDao.update(checked, holder.platilloFavorito.getId());
            Log.e("FAV", String.valueOf(holder.platilloFavorito.getId_platillo()));
        });
    }

    public void noFav(int id){
        for(Platillo p: platillos){
            if(p.getId_platillo() == id){
                notifyItemChanged(platillos.indexOf(p));
                break;
            }
        }
    }

    public void swapData(List<Platillo> platillos){
        this.platillos = platillos;
        notifyDataSetChanged();
    }

    public void setOnClickListener(View.OnClickListener onClickListener){
        this.onClickListener = onClickListener;
    }

    @Override
    public int getItemCount() {
        return this.platillos.size();
    }

    @Override
    public Filter getFilter() {
        if(filter==null)
        {
            filter=new PlatillosFilter(this, filterList);
        }
        return filter;
    }

    class ViewHolder extends RecyclerView.ViewHolder{

        TextView nombre;
        TextView descripcion;
        TextView precio;
        ImageView imagen;
        CheckBox favorito;
        PlatilloFavorito platilloFavorito;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            nombre = itemView.findViewById(R.id.lblNombrePlatillo);
            descripcion = itemView.findViewById(R.id.lblDescripcionPlatillo);
            precio = itemView.findViewById(R.id.lblPrecioPlatillo);
            imagen = itemView.findViewById(R.id.image_platillo);
            favorito = itemView.findViewById(R.id.checkFavorito);

            itemView.setOnClickListener(onClickListener);

        }
    }

}
