package com.c3rberuss.restaurantapp.utils;

import android.content.Context;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.restaurantapp.App;
import com.c3rberuss.restaurantapp.db.AppDatabase;

public class Functions {

    public static String intToString2Digits(int number){
        return (number < 10) ? "0"+String.valueOf(number) : String.valueOf(number);
    }

    public static String numbersToDate(int day, int month, int year){
        return intToString2Digits(day)+"-"+intToString2Digits(month+1)+"-"+String.valueOf(year);
    }

    public static boolean sesionIniciada(){
        return EasySharedPreference.Companion.getBoolean("sesion", false);
    }

    public static void iniciarSesion(){
        EasySharedPreference.Companion.putBoolean("sesion", true);
    }

    public static void cerrarSesion(Context context){
        EasySharedPreference.Companion.putBoolean("sesion", false);
        AppDatabase.getInstance(context).getUsuarioDao().logout();
    }

}
