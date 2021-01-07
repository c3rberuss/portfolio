package com.c3rberuss.restaurantapp.activities;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.c3rberuss.restaurantapp.R;
import com.c3rberuss.restaurantapp.db.AppDatabase;
import com.c3rberuss.restaurantapp.entities.ResponseServer;
import com.c3rberuss.restaurantapp.entities.Usuario;
import com.c3rberuss.restaurantapp.providers.ApiProvider;
import com.google.android.material.textfield.TextInputEditText;
import com.google.gson.Gson;
import com.himanshurawat.hasher.HashType;
import com.himanshurawat.hasher.Hasher;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RegistroActivity extends AppCompatActivity {


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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registro);
        ButterKnife.bind(this);

    }

    @OnClick(R.id.btnRegistrarse)
    public void onViewClicked() {

        final Usuario usuario = new Usuario();
        usuario.setNombre(txtNombre.getText().toString());
        usuario.setFb(false);
        usuario.setCorreo(txtCorreo.getText().toString());
        usuario.setTelefono(txtTelefono.getText().toString());
        usuario.setPwd(Hasher.Companion.hash(txtContra.getText().toString(), HashType.MD5));

        Gson gson = new Gson();
        System.out.println(gson.toJson(usuario));

        ApiProvider.getInstance().registrar(usuario).enqueue(new Callback<Usuario>() {
            @Override
            public void onResponse(Call<Usuario> call, Response<Usuario> response) {
                if(response.code() == 200){

                    AppDatabase.getInstance(RegistroActivity.this)
                            .getUsuarioDao()
                            .insert(response.body());

                    setResult(RESULT_OK);

                    finish();

                }else{
                    Log.e("REGISTRO", "ERROR -> "+String.valueOf(response.code()));
                }
            }

            @Override
            public void onFailure(Call<Usuario> call, Throwable t) {
                Log.e("REGISTRO", t.getMessage());
            }
        });

    }
}
