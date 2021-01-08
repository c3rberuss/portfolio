package com.c3rberuss.crediapp.utils;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import com.c3rberuss.crediapp.MainActivity;


public class BootBroadCast extends BroadcastReceiver{

    @Override
    public void onReceive(Context context, Intent intent) {

        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
            Intent i = new Intent(context, MainActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(i);
        }

        /****** For Start Activity *****//*
        Intent i = new Intent(context, MainActivity.class);
        i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(i);

        *//***** For start Service  ****//*
        Intent myIntent = new Intent(context, TrackingService.class);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            System.out.println("START SERVICE");
            context.startForegroundService(myIntent);
        } else {
            System.out.println("START SERVICE 2");
            context.startService(myIntent);
        }*/
    }

}