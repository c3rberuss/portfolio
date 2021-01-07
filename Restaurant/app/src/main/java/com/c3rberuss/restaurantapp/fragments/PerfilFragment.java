package com.c3rberuss.restaurantapp.fragments;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.c3rberuss.restaurantapp.utils.Functions;
import com.google.android.material.textfield.TextInputEditText;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PerfilFragment extends Fragment {

    @BindView(R.id.imageView2)
    ImageView imageView2;
    @BindView(R.id.textView6)
    TextView textView6;
    @BindView(R.id.divider4)
    View divider4;
    @BindView(R.id.txtNombre)
    TextInputEditText txtNombre;
    @BindView(R.id.txtCorreo)
    TextInputEditText txtCorreo;
    @BindView(R.id.txtTelefono)
    TextInputEditText txtTelefono;
    @BindView(R.id.txtContra)
    TextInputEditText txtContra;
    @BindView(R.id.btnRegistrarse)
    Button btnRegistrarse;

    Activity activity;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.perfil_fragment_layout, container, false);
        ButterKnife.bind(this, view);

        final Usuario usuario = AppDatabase.getInstance(activity).getUsuarioDao().getUsuarioActivo();

        imageView2.setVisibility(View.GONE);
        btnRegistrarse.setText("Cerrar Sesión");
        textView6.setText("Datos personales");
        txtContra.setVisibility(View.GONE);

        txtNombre.setText(usuario.getNombre());
        txtCorreo.setText(usuario.getCorreo());
        txtTelefono.setText(usuario.getTelefono());

        return view;
    }

    @OnClick(R.id.btnRegistrarse)
    void onClick(){
        Functions.cerrarSesion(activity);
        activity.setResult(Activity.RESULT_OK);
        activity.finish();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        activity = (Activity)context;
    }
}
