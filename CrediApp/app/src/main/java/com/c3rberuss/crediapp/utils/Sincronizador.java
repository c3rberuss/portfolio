package com.c3rberuss.crediapp.utils;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.amn.easysharedpreferences.EasySharedPreference;

public class Sincronizador extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        Log.e("SYNC", "EJECUTANDO");
       //Functions.subirCambios(context, false);
        if(EasySharedPreference.Companion.getBoolean("sesion_activa", false)){
            Functions.subirCambios2(context);
        }
    }
}
