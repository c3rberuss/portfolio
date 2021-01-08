package com.c3rberuss.crediapp.adapters;

import android.content.Context;

import com.c3rberuss.crediapp.entities.Frecuencia;
import com.jaiselrahman.hintspinner.HintSpinnerAdapter;

import java.util.List;

public class HintFrecuenciaAdapter extends HintSpinnerAdapter<Frecuencia> {
    public HintFrecuenciaAdapter(Context context, Frecuencia[] objects) {
        super(context, objects);
    }

    public HintFrecuenciaAdapter(Context context, List<Frecuencia> objects) {
        super(context, objects);
    }

    public HintFrecuenciaAdapter(Context context, Frecuencia[] objects, int hint) {
        super(context, objects, hint);
    }

    public HintFrecuenciaAdapter(Context context, Frecuencia[] objects, String hint) {
        super(context, objects, hint);
    }

    public HintFrecuenciaAdapter(Context context, List<Frecuencia> objects, int hint) {
        super(context, objects, hint);
    }

    public HintFrecuenciaAdapter(Context context, List<Frecuencia> objects, String hint) {
        super(context, objects, hint);
    }

    @Override
    public String getLabelFor(Frecuencia frecuencia) {
        return frecuencia.getNombre();
    }
}
