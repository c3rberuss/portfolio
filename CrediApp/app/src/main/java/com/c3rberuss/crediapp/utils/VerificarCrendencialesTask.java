package com.c3rberuss.crediapp.utils;

import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Build;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.crediapp.MainActivity;
import com.c3rberuss.crediapp.R;
import com.c3rberuss.crediapp.database.AppDatabase;
import com.c3rberuss.crediapp.entities.Usuario;
import com.c3rberuss.crediapp.providers.ApiProvider;

import java.io.IOException;

import retrofit2.Response;

public class VerificarCrendencialesTask extends AsyncTask<Context, Void, Void> {

    private OnVerify onVerify;
    private Context context;
    Dialog verificar;

    public VerificarCrendencialesTask(OnVerify onVerify, Context context) {
        this.onVerify = onVerify;
        this.context = context;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected Void doInBackground(Context... contexts) {

        if (EasySharedPreference.Companion.getBoolean("sesion_activa", false)) {

            try {
                Response<Usuario> response = ApiProvider.getWebService().auth(EasySharedPreference.Companion.getString("usr", "c3rberuss"),
                        EasySharedPreference.Companion.getString("pss", "0000")).execute();

                this.onVerify.verify(response.isSuccessful() && response.code()==200, response.body());

            } catch (IOException e) {
                e.printStackTrace();
            }

        } else {
            //goToLogin();
            onVerify.ondefault();
        }

        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }
}
