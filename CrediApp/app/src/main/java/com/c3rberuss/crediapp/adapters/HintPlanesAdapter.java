package com.c3rberuss.crediapp.adapters;

import android.content.Context;

import com.c3rberuss.crediapp.entities.Plan;
import com.jaiselrahman.hintspinner.HintSpinnerAdapter;

import java.util.List;

public class HintPlanesAdapter extends HintSpinnerAdapter<Plan> {
    public HintPlanesAdapter(Context context, Plan[] objects) {
        super(context, objects);
    }

    public HintPlanesAdapter(Context context, List<Plan> objects) {
        super(context, objects);
    }

    public HintPlanesAdapter(Context context, Plan[] objects, int hint) {
        super(context, objects, hint);
    }

    public HintPlanesAdapter(Context context, Plan[] objects, String hint) {
        super(context, objects, hint);
    }

    public HintPlanesAdapter(Context context, List<Plan> objects, int hint) {
        super(context, objects, hint);
    }

    public HintPlanesAdapter(Context context, List<Plan> objects, String hint) {
        super(context, objects, hint);
    }

    @Override
    public String getLabelFor(Plan object) {
        return object.getNombre();
    }
}
