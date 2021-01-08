package com.c3rberuss.crediapp.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.utils.Functions;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.List;

public class CuotasAdapter extends RecyclerView.Adapter<CuotasAdapter.CuotasViewHolder> {


    List<String> cuotas;
    Context context;
    double cuota;
    private DecimalFormat df;
    private boolean solointeres;
    private double monto_final;
    private double incremento;
    private double monto;

    public CuotasAdapter(List<String> cuotas, Context context, double cuota, boolean solointeres, double monto) {
        this.cuotas = cuotas;
        this.context = context;
        this.cuota = cuota;
        this.monto = monto;
        this.solointeres = solointeres;
        this.cuotas.add(0, "Fecha");
        this.cuotas.add("TOTAL");

        this.df = new DecimalFormat("######.####");
        this.df.setRoundingMode(RoundingMode.CEILING);
    }

    @NonNull
    @Override
    public CuotasViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.cuota_item_layout, parent, false);

        return new CuotasViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull CuotasViewHolder holder, int position) {

        String fecha_tmp = this.cuotas.get(position);

        if(position == 0){
            holder.desc.setText("Descripcion");
            holder.valor.setText("Valor");
            holder.fecha.setText("Fecha");
            holder.numero.setText("N°");
        }else if(solointeres && position > 0 && position < getItemCount()-2){

            String pos = Functions.intToString2Digits(position);
            final String desc = "CUOTA "+pos+"/"+String.valueOf(getItemCount()-2);
            holder.desc.setText(desc);
            holder.valor.setText(String.valueOf(cuota));
            holder.fecha.setText(fecha_tmp);
            holder.numero.setText(pos);

        }else if(!solointeres && position > 0 && position < getItemCount()-1){

            String pos = Functions.intToString2Digits(position);
            final String desc = "CUOTA "+pos+"/"+String.valueOf(getItemCount()-2);
            holder.desc.setText(desc);
            holder.valor.setText(String.valueOf(cuota));
            holder.fecha.setText(fecha_tmp);
            holder.numero.setText(pos);

        }else if(solointeres && position == getItemCount()-2){

            String pos = Functions.intToString2Digits(position);
            final String desc = "CUOTA "+pos+"/"+String.valueOf(getItemCount()-2);
            holder.desc.setText(desc);
            holder.valor.setText(String.valueOf(cuota + monto));
            holder.fecha.setText(fecha_tmp);
            holder.numero.setText(pos);

        } else  if(position == getItemCount()-1){
            holder.desc.setText("");

           if(solointeres){
               holder.valor.setText(String.valueOf(df.format((cuota * (getItemCount()-2) + monto))));
           }else{
               holder.valor.setText(String.valueOf(df.format(cuota * (getItemCount()-2))));
           }

            holder.fecha.setText(fecha_tmp);
            holder.numero.setText("");
        }

    }

    @Override
    public int getItemCount() {
        return this.cuotas.size();
    }

    class CuotasViewHolder extends RecyclerView.ViewHolder{

        TextView numero;
        TextView desc;
        TextView fecha;
        TextView valor;

        public CuotasViewHolder(@NonNull View itemView) {
            super(itemView);

            this.numero = itemView.findViewById(R.id.n_cuota_item);
            this.desc = itemView.findViewById(R.id.descripcion_cuota_item);
            this.fecha = itemView.findViewById(R.id.fecha_cuota_item);
            this.valor = itemView.findViewById(R.id.valor_cuota_item);
        }
    }
}
