package com.c3rberuss.crediapp.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.activities.SolicitudCreditoActivity;
import com.c3rberuss.crediapp.entities.Garantia;
import com.c3rberuss.crediapp.utils.Functions;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class GarantiasAdapter extends RecyclerView.Adapter<GarantiasAdapter.GarantiaViewHolder> {


    public List<Garantia> garantias = new ArrayList<>();
    private View.OnClickListener onClickListener;
    private int mode;

    public GarantiasAdapter(int mode) {

        this.mode = mode;

    }

    @NonNull
    @Override
    public GarantiaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_documento_layout, parent, false);
        return new GarantiaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull GarantiaViewHolder holder, int position) {

        final Garantia gar = garantias.get(position);

        holder.nombre.setText(gar.getDescripcion());
        holder.descripcion.setText(gar.getDireccion());

        holder.subtitulo.setText("Dirección");

        Picasso.get().load(new File(gar.getUrl())).centerCrop().fit().into(holder.foto);

        holder.eliminar.setOnClickListener(v->{

            notifyItemRemoved(position);
            Functions.borrarArchivo(gar.getUrl());
            this.garantias.remove(gar);

            if(mode == 0){
                SolicitudCreditoActivity.garantiasStep.markAsCompletedOrUncompleted(true);
            }

        });

    }

    @Override
    public int getItemCount() {
        return garantias.size();
    }

    public void addDocumento(Garantia gar){
        this.garantias.add(gar);
        notifyItemInserted(this.garantias.size()-1);
    }

    public void setOnClickListener(View.OnClickListener listener){
        this.onClickListener = listener;
    }

    class GarantiaViewHolder extends RecyclerView.ViewHolder{

        TextView nombre;
        TextView descripcion;
        ImageView foto;
        ImageButton eliminar;
        TextView subtitulo;


        public GarantiaViewHolder(@NonNull View itemView) {
            super(itemView);

            itemView.setOnClickListener(onClickListener);
            nombre = itemView.findViewById(R.id.lblNombreDocumento);
            descripcion = itemView.findViewById(R.id.lblDecripcionDocumento);
            foto = itemView.findViewById(R.id.imagen_documento);
            eliminar = itemView.findViewById(R.id.btnEliminarDocumento);

            subtitulo =itemView.findViewById(R.id.textView19);
        }
    }

}
