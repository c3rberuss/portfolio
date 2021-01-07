package com.c3rberuss.restaurantapp.utils;


import android.widget.Filter;

import com.c3rberuss.restaurantapp.adapters.PlatillosAdapter;
import com.c3rberuss.restaurantapp.entities.Platillo;

import java.util.ArrayList;
import java.util.List;

public class PlatillosFilter extends Filter {

    private PlatillosAdapter adapter;
    private List<Platillo> filterList;

    public PlatillosFilter(PlatillosAdapter adapter, List<Platillo> filterList) {
        this.adapter = adapter;
        this.filterList = filterList;

        System.out.println("COUNT FILTER "+ String.valueOf(filterList.size()));
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
            List<Platillo> platillosFiltrados =new ArrayList<>();

            for (int i=0;i<filterList.size();i++)
            {
                //CHECK
                if(filterList.get(i).getNombre().toUpperCase().contains(constraint)) {
                    //ADD PLAYER TO FILTERED PLAYERS
                    platillosFiltrados.add(filterList.get(i));
                }
            }

            results.count= platillosFiltrados.size();
            results.values= platillosFiltrados;
        }else
        {
            results.count = filterList.size();
            results.values = filterList;

        }


        return results;
    }

    @Override
    protected void publishResults(CharSequence constraint, FilterResults results) {

        adapter.platillos = (List<Platillo>) results.values;
        adapter.notifyDataSetChanged();
    }
}