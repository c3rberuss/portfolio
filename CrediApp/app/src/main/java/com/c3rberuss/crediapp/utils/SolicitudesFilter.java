package com.c3rberuss.crediapp.utils;


import android.content.Context;
import android.widget.Filter;

import com.c3rberuss.crediapp.adapters.SolicitudAdapter;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.SolicitudCredito;

import java.util.ArrayList;
import java.util.List;

public class SolicitudesFilter extends Filter {

    SolicitudAdapter adapter;
    List<SolicitudCredito> filterList;
    Context context;

    public SolicitudesFilter(SolicitudAdapter adapter, List<SolicitudCredito> filterList, Context context) {
        this.adapter = adapter;
        this.filterList = filterList;
        this.context = context;
    }

    @Override
    protected FilterResults performFiltering(CharSequence constraint) {
        FilterResults results=new FilterResults();
        //CHECK CONSTRAINT VALIDITY
        if(constraint != null && constraint.length() > 0)
        {
            //CHANGE TO UPPER
            constraint=constraint.toString().toUpperCase();
            //STORE OUR FILTERED PLAYERS
            List<SolicitudCredito> clientesFiltrados =new ArrayList<>();

            for (int i=0;i<filterList.size();i++)
            {
                final String nombre_cliente = AppDatabase.getInstance(context).getClienteDao().getNombre(filterList.get(i).getId_cliente());
                //CHECK
                if(nombre_cliente.toUpperCase().contains(constraint))
                {
                    //ADD  values TO FILTERED clientes
                    clientesFiltrados.add(filterList.get(i));
                }
            }
            results.count= clientesFiltrados.size();
            results.values= clientesFiltrados;
        }else
        {
            results.count=filterList.size();
            results.values=filterList;
        }
        return results;
    }

    @Override
    protected void publishResults(CharSequence constraint, FilterResults results) {
        adapter.solicitudCreditos= (List<SolicitudCredito>) results.values;
        //REFRESH
        adapter.notifyDataSetChanged();
    }
}