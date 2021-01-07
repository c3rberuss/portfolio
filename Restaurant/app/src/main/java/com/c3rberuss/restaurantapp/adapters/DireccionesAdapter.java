package com.c3rberuss.restaurantapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.ImageButton;
import android.widget.Switch;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.Direccion;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DireccionesAdapter extends RecyclerView.Adapter<DireccionesAdapter.ViewHolderDireccion> {

    public List<Direccion> direccions = new ArrayList<>();
    Switch anterior;
    int pos_ant = 0;
    Context context;

    public DireccionesAdapter(List<Direccion> dirs, Context context) {
        this.context = context;
        this.direccions = dirs;
    }

    @NonNull
    @Override
    public ViewHolderDireccion onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.direccion_item_layout, parent, false);
        return new ViewHolderDireccion(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolderDireccion holder, int position) {

        final Direccion dir = direccions.get(position);
        holder.lblDireccion.setText(dir.getDireccion());

        if(anterior != null){
            anterior.setChecked(false);
            direccions.get(pos_ant).setDefecto(false);
            notifyItemChanged(pos_ant);
        }

        holder.switchUsar.setChecked(dir.isDefecto());

        holder.switchUsar.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if(isChecked){

                if(anterior != null){
                    anterior.setChecked(false);
                    direccions.get(pos_ant).setDefecto(false);
                    notifyItemChanged(pos_ant);
                    pos_ant = position;
                }

                anterior = holder.switchUsar;
            }
        });

    }

    public void swapData(List<Direccion> direccio){
        this.direccions.clear();
        this.direccions.addAll(direccio);
        notifyDataSetChanged();
    }

    public void insertDir(Direccion direccion) {

        if(anterior != null){
            anterior.setChecked(false);
        }

        direccions.add(direccion);
        notifyItemInserted(direccions.size() - 1);
    }

    @Override
    public int getItemCount() {
        return direccions.size();
    }

    class ViewHolderDireccion extends RecyclerView.ViewHolder {

        @BindView(R.id.lblDireccion)
        TextView lblDireccion;
        @BindView(R.id.switchUsar)
        Switch switchUsar;
        @BindView(R.id.btnEliminar)
        ImageButton btnEliminar;

        public ViewHolderDireccion(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        @OnClick(R.id.btnEliminar)
        void OnClick(){

            final int pos = getAdapterPosition();

            notifyItemRemoved(pos);
            AppDatabase.getInstance(context).getDireccionDAo().delete(direccions.get(pos));
            direccions.remove(pos);
        }
    }
}
