package com.c3rberuss.crediapp.utils;


import android.widget.Filter;

import com.c3rberuss.crediapp.adapters.CandidatosAdapter;
import com.c3rberuss.crediapp.entities.Prestamo;

import java.util.ArrayList;
import java.util.List;

public class CandidatoFilter extends Filter {

    CandidatosAdapter adapter;
    List<Prestamo> filterList;

    public CandidatoFilter(CandidatosAdapter adapter, List<Prestamo> filterList) {
        this.adapter = adapter;
        this.filterList = filterList;
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
            List<Prestamo> clientesFiltrados =new ArrayList<>();

            for (int i=0;i<filterList.size();i++)
            {
                //CHECK
                if(filterList.get(i).getNombre().toUpperCase().contains(constraint))
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
        adapter.clientes = (List<Prestamo>) results.values;
        //REFRESH
        adapter.notifyDataSetChanged();
    }
}