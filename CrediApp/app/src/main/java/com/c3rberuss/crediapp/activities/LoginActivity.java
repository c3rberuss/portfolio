package com.c3rberuss.crediapp.activities;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.Button;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.amn.easysharedpreferences.EasySharedPreferenceConfig;
import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.database.dao.PermisoDao;
import com.c3rberuss.crediapp.database.dao.UsuarioDao;
import com.c3rberuss.crediapp.entities.Usuario;
import com.c3rberuss.crediapp.providers.WebService;
import com.c3rberuss.crediapp.utils.Functions;
import com.c3rberuss.crediapp.utils.TrackingService;
import com.developer.kalert.KAlertDialog;
import com.google.android.material.textfield.TextInputEditText;
import com.google.gson.GsonBuilder;
import com.himanshurawat.hasher.HashType;
import com.himanshurawat.hasher.Hasher;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class LoginActivity extends AppCompatActivity {

    public static WebService ws;
    private Retrofit retrofit;
    private TextInputEditText usuario;
    private TextInputEditText contra;
    private Button btnIngresar;
    private KAlertDialog error;
    private AppDatabase db;
    private UsuarioDao usuarioDao;
    private PermisoDao permisoDao;
    private TextWatcher watcher = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

        }

        @Override
        public void afterTextChanged(Editable s) {
            if(usuario.getText().toString().length() > 1 && contra.getText().toString().length() > 0){
                btnIngresar.setEnabled(true);
            }else{
                btnIngresar.setEnabled(false);
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_layout);



        EasySharedPreferenceConfig.Companion
                .initDefault(new EasySharedPreferenceConfig.Builder()
                        .inputFileName("crediapp_preferences") .inputMode(Context.MODE_PRIVATE) .build());

        this.retrofit = new Retrofit.Builder().baseUrl(WebService.SERVER_URL)
                .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().serializeNulls().create()))
                .build();

        ws = retrofit.create(WebService.class);
        db = AppDatabase.getInstance(this);

        //DAO
        usuarioDao = db.getUsuarioDao();
        permisoDao = db.getPermisoDao();

        usuario = findViewById(R.id.txtUsuario);
        contra = findViewById(R.id.txtContra);
        btnIngresar = findViewById(R.id.btnIngresar);

        usuario.addTextChangedListener(watcher);
        contra.addTextChangedListener(watcher);

        btnIngresar.setEnabled(false);

        Functions.permisosApp(this);

        final Dialog dialog = Functions.progressDialog(this, "Ingresando...");

        btnIngresar.setOnClickListener(v->{
            //Functions.permisosApp(this);

            initError("Error", "Credenciales incorrectas.");
            dialog.show();

            ws.auth(usuario.getText().toString(), Hasher.Companion.hash(contra.getText().toString(), HashType.MD5)).enqueue(new Callback<Usuario>() {
                @Override
                public void onResponse(Call<Usuario> call, Response<Usuario> response) {

                    if(response.code() == 200){

                        usuarioDao.deleteAll();
                        usuarioDao.insert(response.body());

                        permisoDao.deleteAll();
                        permisoDao.insert(response.body().getPermisos());

                        dialog.dismiss();
                        btnIngresar.setEnabled(false);

                        goToMain();

                    }else{
                        dialog.dismiss();
                        error.show();
                    }

                }

                @Override
                public void onFailure(Call<Usuario> call, Throwable t) {

                    if(usuarioDao.auth(usuario.getText().toString(),
                            Hasher.Companion.hash(contra.getText().toString(), HashType.MD5)) > 0){

                        dialog.dismiss();
                        goToMain();

                    }else{
                        dialog.dismiss();
                        error.show();
                    }

                }
            });

        });

    }

    private void goToMain(){
        EasySharedPreference.Companion.putBoolean("sesion_activa", true);
        EasySharedPreference.Companion.putString("pss", Hasher.Companion.hash(contra.getText().toString(), HashType.MD5));
        EasySharedPreference.Companion.putString("usr", usuario.getText().toString());


        final Intent intent = new Intent(LoginActivity.this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
        startActivity(intent);
        LoginActivity.this.finish();
    }


    private void initError(String titulo, String mensaje){
        error = new KAlertDialog(this, KAlertDialog.ERROR_TYPE);
        error.setTitleText(titulo);
        error.setContentText(mensaje);
        error.showCancelButton(false);
        error.setConfirmText("Aceptar");
        error.setConfirmClickListener(Dialog::dismiss);
        error.setCancelable(true);
    }

}
