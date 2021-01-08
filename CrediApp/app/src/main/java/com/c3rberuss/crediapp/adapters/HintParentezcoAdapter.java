package com.c3rberuss.crediapp.adapters;

import android.content.Context;

import com.c3rberuss.crediapp.entities.Parentezco;
import com.jaiselrahman.hintspinner.HintSpinnerAdapter;

import java.util.List;

public class HintParentezcoAdapter extends HintSpinnerAdapter<Parentezco> {
    public HintParentezcoAdapter(Context context, Parentezco[] objects) {
        super(context, objects);
    }

    public HintParentezcoAdapter(Context context, List<Parentezco> objects) {
        super(context, objects);
    }

    public HintParentezcoAdapter(Context context, Parentezco[] objects, int hint) {
        super(context, objects, hint);
    }

    public HintParentezcoAdapter(Context context, Parentezco[] objects, String hint) {
        super(context, objects, hint);
    }

    public HintParentezcoAdapter(Context context, List<Parentezco> objects, int hint) {
        super(context, objects, hint);
    }

    public HintParentezcoAdapter(Context context, List<Parentezco> objects, String hint) {
        super(context, objects, hint);
    }

    @Override
    public String getLabelFor(Parentezco parentezco) {
        return parentezco.getNombre();
    }
}
