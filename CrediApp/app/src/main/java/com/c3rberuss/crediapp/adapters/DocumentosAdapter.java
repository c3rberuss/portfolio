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
import com.c3rberuss.crediapp.entities.Archivo;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.Functions;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class DocumentosAdapter extends RecyclerView.Adapter<DocumentosAdapter.DocumentosViewHolder> {


    public List<Archivo> documentos = new ArrayList<>();
    private View.OnClickListener onClickListener;
    private int mode = 0;

    public DocumentosAdapter(int mode) {
        this.mode = mode;
    }

    @NonNull
    @Override
    public DocumentosViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_documento_layout, parent, false);
        return new DocumentosViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull DocumentosViewHolder holder, int position) {

        final Archivo doc = documentos.get(position);

        holder.nombre.setText(doc.getNombre());
        holder.descripcion.setText(doc.getDescripcion());

        if(mode == 0){

            //Picasso.get().load(new File(doc.getUrl())).centerCrop().fit().into(holder.foto);

            if(doc.isSincronizado()){
                Picasso.get().load(WebService.ROOT_URL +doc.getUrl()).centerCrop().fit().into(holder.foto);
            }else{
                Picasso.get().load(new File(doc.getUrl())).centerCrop().fit().into(holder.foto);
            }

            holder.eliminar.setOnClickListener(v->{

                notifyItemRemoved(position);
                Functions.borrarArchivo(doc.getUrl());
                this.documentos.remove(doc);

            });

        }else{
            if(doc.isSincronizado()){
                Picasso.get().load(WebService.ROOT_URL +doc.getUrl()).centerCrop().fit().into(holder.foto);
            }else{
                Picasso.get().load(new File(doc.getUrl())).centerCrop().fit().into(holder.foto);
            }
            holder.eliminar.setVisibility(View.GONE);
        }
    }

    @Override
    public int getItemCount() {
        return documentos.size();
    }

    public void addDocumento(Archivo doc){
        this.documentos.add(doc);
        notifyItemInserted(this.documentos.size()-1);
    }

    public void setOnClickListener(View.OnClickListener listener){
        this.onClickListener = listener;
    }

    public void swapData(List<Archivo> archivos_){
        this.documentos.clear();
        this.documentos.addAll(archivos_);
        notifyDataSetChanged();
    }

    class DocumentosViewHolder extends RecyclerView.ViewHolder{

        TextView nombre;
        TextView descripcion;
        ImageView foto;
        ImageButton eliminar;

        public DocumentosViewHolder(@NonNull View itemView) {
            super(itemView);

            itemView.setOnClickListener(onClickListener);
            nombre = itemView.findViewById(R.id.lblNombreDocumento);
            descripcion = itemView.findViewById(R.id.lblDecripcionDocumento);
            foto = itemView.findViewById(R.id.imagen_documento);
            eliminar = itemView.findViewById(R.id.btnEliminarDocumento);
        }
    }

}
